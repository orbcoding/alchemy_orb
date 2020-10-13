# Included in application.rb/before_initialize as acts_as_essence needs to be overwritten before its inheritors load
module AlchemyOrb::ModelExtension::Alchemy::EssenceExtension
	# def self.included(base)
	# 	base.extend(ClassMethods)
	# end

	module ClassMethods
		include Alchemy::Essence::ClassMethods

		def acts_as_essence(options = {})
			class_eval <<-RUBY, __FILE__, __LINE__ + 1
				attr_writer :contents_attributes # Add content attributes for cross validation
				include Alchemy::EssenceExtension::InstanceMethods
			RUBY

			super
		end
	end

	module InstanceMethods
		def validate_min_length(value)
			return if ingredient.blank?
			if ingredient.length < value
				errors.add(ingredient_column, :min_length)
				validation_errors << { min_length: {
					length: value,
				}}
			end
		end

		def validate_max_length(value)
			return if ingredient.blank?

			text = if self.instance_of? Alchemy::EssenceRichtext
				strip_content
			else
				ingredient
			end

			if text.length > value
				errors.add(ingredient_column, :max_length)
				validation_errors << { max_length: {
					length: value,
				}}
			end
		end

		def validate_if_field_error(test_truth, condition, tested_value, value)
			valid = false
			# Error state would be "blank" if testing for presence=true and test_truth=true. Use translation keys if multilang
			error_state = nil

			case condition
			when 'presence'
				valid = (tested_value == true && value.present?) || (tested_value == false && value.blank?)
				error_state = test_truth ?
				 	(tested_value ? 'blank' : 'present') :
					(tested_value ? 'present' : 'blank')
			when 'is'
				error_state = test_truth ? "not #{tested_value}" : "#{tested_value}"
				valid = tested_value == value
			when 'not'
				error_state = test_truth ? "#{tested_value}" : "not #{tested_value}"
				valid = tested_value != value
			end

			valid = test_truth ? valid : !valid # Reverse valid if test_truth = false

			!valid ? error_state : nil # No error message if valid
		end

		def validate_if_other_field_name_value(condition)
			# Continue to test other field validation condition
			name = Alchemy::Content.translated_label_for(condition[:content])
			value = if condition['element'] && condition['element'] != element.name
				el = (element.page.elements + element.page.fixed_elements).detect{|el| el.name == condition['element']}
				if el.present?
					content = el.content_by_name(condition['content'])
					name = "#{el.display_name} &#8594; #{Alchemy::Content.translated_label_for(condition[:content], el.name)}"
				end
				content.present? ? content.ingredient : nil
			elsif @contents_attributes
				content = element.content_by_name(condition['content'])
				return nil if !content
				content_hash = @contents_attributes[content.id.to_s]
				content_hash['ingredient'] || content_hash['picture_id'] || content_hash['attachment_id']
			else
				element.content_by_name(condition['content']).ingredient
			end

			[name, value]
		end

		def validate_if(conditions)
			conditions.each do |condition|
				condition['then'].keys.each do |validation|
					tested_value = condition['then'][validation]

					# If field value already valides wanted value, no need to check if validation condition applies
					error_state = validate_if_field_error(true, validation, tested_value, ingredient)

					next if !error_state

					other_field, other_value = validate_if_other_field_name_value(condition)

					other_validation, other_tested_value =
						condition.key?('presence') && ['presence', condition['presence']] ||
						condition.key?('is') && ['is', condition['is']] ||
						condition.key?('not') && ['not', condition['not']]

					# If the validation condition does not apply it doesn't matter if the wanted value didn't valid
					other_error_state = validate_if_field_error(false, other_validation, other_tested_value, other_value)

					next if !other_error_state

					# Validation condition active and value didnt valid => send error
					field_error = validation == 'is' ? # Convert can't be not value => has to be value
						"has to be #{error_state.gsub('not ', '')}" :
						"can\'t be #{error_state}"

					errors.add(ingredient_column, :if)
					validation_errors << { if: {
						field_error: field_error,
						other_field: other_field,
						other_field_error: "is #{other_error_state}"
					}}
				end
			end
		end
	end
end

# ActiveRecord::Base.include(Alchemy::EssenceExtension)

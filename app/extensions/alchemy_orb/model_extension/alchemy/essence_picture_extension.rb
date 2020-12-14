module AlchemyOrb::ModelExtension::Alchemy::EssencePictureExtension
	include AlchemyOrb::ModelExtension::Alchemy::Picture::TransformationsExtension

	# Allow skipping presence validation so alt text can be saved
	def self.prepended(base)
		base.attr_writer :skip_presence_validation
	end

	def validate_presence(validate = true)
		return if @skip_presence_validation
		super
	end

	def validate_alt_tag(value)
		unless ingredient.blank? || alt_tag.present?
			errors.add(ingredient_column, :alt_tag)
			validation_errors << :alt_tag
		end
	end

	# Add more validations
	def validate_min_size(value)
		dim = render_size.present? ? render_size : value

		width, height = dim.split('x').map{|s| s.to_i}

		unless ingredient.blank? || (
			ingredient.image_file_width >= width && (
				height.blank? ||
				ingredient.image_file_height >= height
			)
		)

			errors.add(ingredient_column, :min_size)
			validation_errors << { min_size: {
				size: value,
			}}
		end
	end

	def validate_title(value)
		unless ingredient.blank? || title.present?
			errors.add(ingredient_column, :title)
			validation_errors << :title
		end
	end
end

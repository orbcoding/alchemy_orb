module AlchemyOrb::ModelExtension::Alchemy::ElementExtension
	# include AlchemyOrb::ModelExtension::Alchemy::Element::ElementContentsExtension
	def view_component
		Struct.new(:element, :namespace) do
			def new(**args)
				namespace.constantize.new(element: element, **args)
			end

			def config
				Object.const_defined?("#{namespace}::Config") ?
					"#{namespace}::Config".constantize.new(element: element) :
					nil
			end
		end.new(
			self,
			"alchemy/element/#{name}_component".classify
		)
	end

	# Redirect element partials to component
	def to_partial_path
		"alchemy/elements/redirect_element_to_component"
	end

	# Allow passing hash with additional translation vars { e: { t_var: value }}
	def essence_error_messages
		messages = []
		essence_errors.each do |content_name, errors|
			errors.each do |e|
				error = e.kind_of?(Hash) ? e.keys.first : e
				t_vars = e.kind_of?(Hash) ? e.values.first : {}

				messages << Alchemy.t(
					"#{name}.#{content_name}.#{error}",
					{
						scope: 'content_validations',
						default: [
							"fields.#{content_name}.#{error}".to_sym,
							"errors.#{error}".to_sym
						],
						field: Alchemy::Content.translated_label_for(content_name, name)
					}.merge(t_vars)
				)
			end
		end

		messages
	end
end

module AlchemyOrb::Extension::Models::Alchemy::ElementExtension
	# include AlchemyOrb::Extension::Models::Alchemy::Element::ElementContentsExtension

	# Redirect element partials to component
	def to_partial_path
		"alchemy/elements/redirect_to_component"
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

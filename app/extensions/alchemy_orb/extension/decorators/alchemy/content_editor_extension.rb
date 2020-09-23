module AlchemyOrb::Extension::Decorators::Alchemy::ContentEditorExtension
	def data_attributes
		data = super

		# Disable tinymce hotkeys depending on which formats are available
		disable_keys = Set[] # Set always unique

		if settings.dig('tinymce', 'toolbar')
			toolbar = settings['tinymce']['toolbar'].join(' ').split(' ')
			disable_keys.merge(['bold', 'italic', 'underline', 'fullscreen', 'alchemy_link'].reject{ |style|
				toolbar.include?(style)
			})
		end

		if content.has_validations?
			definition['validate'].each do |validation|
				if validation.key?('max_length')
					data[:max_length] = validation['max_length']
					disable_keys.add('enter')
				end

				if validation.key?('min_length')
					data[:min_length] = validation['min_length']
					disable_keys.add('enter')
				end
			end
		end

		disable_keys.add('enter') if settings['no_newline']
		data[:disable_keys] = disable_keys if disable_keys.any?

		data
	end
end

module AlchemyOrb::HelperExtension::Alchemy::Admin::ContentsHelperExtension
	def render_content_name(content)
		super

		content_name = content.name_for_label

		if content.has_validations? &&
			content.definition['validate'].detect{|v|
				v.key?('presence')
			}
			"#{content_name}<span class='validation_indicator'>*</span>".html_safe
		else
			content_name
		end
	end
end

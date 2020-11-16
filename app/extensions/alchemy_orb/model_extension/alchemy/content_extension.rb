module AlchemyOrb::ModelExtension::Alchemy::ContentExtension
	# Allows content default value to come from user or page
	def default_value(default = definition[:default])
		if default && default.is_a?(String)
			if default.start_with?('_page_')
				new_default = default[6..]
				return page.send(new_default)
			end

			if default.start_with?('_user_')
				new_default = default[6..]
				return Current.alchemist.send(new_default)
			end
		end

		super
	end
end

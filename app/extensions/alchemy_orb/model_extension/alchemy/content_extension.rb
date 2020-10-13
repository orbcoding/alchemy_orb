module AlchemyOrb::ModelExtension::Alchemy::ContentExtension
	# Allows content default value to come from user or page
	def default_value(default = definition[:default])
		if default && default.is_a?(String)
			if default.start_with?('_page_')
				default.slice!(0, 6)
				return page.send(default)
			end

			if default.start_with?('_user_')
				default.slice!(0, 6)
				return Current.alchemist.send(default)
			end
		end

		super
	end
end

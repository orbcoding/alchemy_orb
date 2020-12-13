module AlchemyOrb::ModelExtension::Alchemy::ContentExtension
	# Allows content default value to come from user or page
	def default_value(default = definition[:default])
		if default && default.is_a?(String)
			if default.include?('@page')
				page_match = default.match(/@page([a-zA-Z]|\.|_)*/)[0]
				page_call = page_match.gsub('@', '')
				new_default = default.gsub(page_match, eval(page_call))
				return new_default
			end

			if default.start_with?('_user_')
				new_default = default[6..]
				return Current.alchemist.send(new_default)
			end
		end

		super
	end
end

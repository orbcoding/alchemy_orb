# Extended to AlchemyOrb
module AlchemyOrb::Logger
	def log(message, newlines: false, newline: false)
		msg = "\e[32m\[AlchemyOrb]\e[0m " + message
		msg = "\n#{msg}\n\n" if newlines
		msg = "#{msg}\n\n"if newline
		puts msg
	end
end

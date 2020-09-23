module AlchemyOrb
	module BaseHelper
		def ap(*args)
			awesome_print(*args)
		end

		def alchemy_engine
			@@alchemy_engine ||= ::Alchemy::Engine.routes.url_helpers
		end
	end
end

module AlchemyOrb
	module BaseHelper
		def ap(*args)
			awesome_print(*args)
		end

		def alchemy_engine
			@@alchemy_engine ||= ::Alchemy::Engine.routes.url_helpers
		end

		def deep_merge_array_of_hashes(*args)
			array = []
			args.each do |h|

			end
		end
	end
end

namespace :alchemy_orb do
	namespace :elements do
		desc "Merge elements"
		task :merge do
			require 'alchemy_orb/element_file_merger'
			AlchemyOrb::ElementService.merge
		end
	end
end

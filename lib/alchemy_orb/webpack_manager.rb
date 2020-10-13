class AlchemyOrb::WebpackManager
  class << self
    def alchemy_orb_js(path)
      File.join(Gem.loaded_specs['alchemy_orb'].full_gem_path, 'app/assets/javascripts/alchemy_orb/', path)
		end

		def hej
			'hejsan'
		end

    # def alchemy_orb_css(path)
    #   File.join(Gem.loaded_specs['alchemy_orb'].full_gem_path, 'app/assets/stylesheets/alchemy_orb/', path)
    # end
  end
end

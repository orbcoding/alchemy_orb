module AlchemyOrb::AssetPath
  extend self
  # If we need precompiled asset url eg in initializer before sprockets init/asset_path is generated
  # Own solution to same problem as here: https://stackoverflow.com/questions/27474913/how-to-access-an-asset-path-with-a-digest-in-a-rails-initializer
  def get(path)
    "/assets/#{Rails.env.development? || manifest.nil? ? path : manifest.dig('assets', path)}"
  end

  # Javascript directory path is loaded to asset paths in startup initializer
  def javascript
    AlchemyOrb::Engine.root.join('app', 'javascript')
  end


  private

  def manifest
    @@manifest ||= parse_manifest
  end

  def parse_manifest
    path = Dir[Rails.root.join('public', 'assets', '.sprockets-manifest*.json')].first
    JSON.parse(File.read(path)) if path
  end


  # def root(*paths)
  #   File.join(AlchemyOrb::Engine.root, *paths)
  # end

  # def asset(path = '/')
  #   root('app/assets')
  # end

  # Alchemy orb assets
  # def js(path = '/') # Index file
  #   root('app/javascript/alchemy_orb/javascript', path)
  # end

  # def js_main
  #   root('app/javascript/alchemy_orb/alchemy_orb')
  # end

  # def css(path = '/') # Index file
  #   root('app/javascript/alchemy_orb/stylesheets', path)
  # end

  # def css_main
  #   root('app/javascript/alchemy_orb/alchemy_orb')
  # end

  # # Alchemy assets
  # def alchemy_admin_js(path = '/')
  #   root('app/javascript/alchemy/javascript/admin', path)
  # end

  # def alchemy_admin_js_main
  #   root('app/javascript/alchemy/admin')
  # end

  # def alchemy_admin_css(path = '/')
  #   root('app/javascript/alchemy/stylesheets/admin', path)
  # end

  # def alchemy_admin_css_main
  #   root('app/javascript/alchemy/admin')
  # end

end

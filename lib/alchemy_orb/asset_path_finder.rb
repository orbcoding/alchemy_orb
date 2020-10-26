module AlchemyOrb::AssetPathFinder
  extend self

  def alchemy_orb_js(path)
    File.join(Gem.loaded_specs['alchemy_orb'].full_gem_path, 'app/javascript', path)
  end

  def alchemy_orb_css(path)
    File.join(Gem.loaded_specs['alchemy_orb'].full_gem_path, 'app/javascript/stylesheets', path)
  end

  def alchemy_orb_asset(path)
    File.join(Gem.loaded_specs['alchemy_orb'].full_gem_path, 'app/assets', path)
  end

  # If we need precompiled asset url eg in initializer before sprockets init/asset_path is generated
  # Own solution to same problem as here: https://stackoverflow.com/questions/27474913/how-to-access-an-asset-path-with-a-digest-in-a-rails-initializer
  def from_manifest(path)
    "/assets/#{Rails.env.development? || manifest.nil? ? path : manifest.dig('assets', path)}"
  end


  private

  def manifest
    @@manifest ||= parse_manifest
  end

  def parse_manifest
    path = Dir[Rails.root.join('public', 'assets', '.sprockets-manifest*.json')].first
    JSON.parse(File.read(path)) if path
  end
end

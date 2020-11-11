module AlchemyOrb
  class Engine < ::Rails::Engine
    isolate_namespace AlchemyOrb
    engine_name "alchemy_orb"

    config.generators do |g|
      g.orm :active_record
      g.test_framework nil
      g.template_engine nil
      g.stylesheets false
      g.assets  false
      g.helper false
      g.stylesheets false
    end
  end
end

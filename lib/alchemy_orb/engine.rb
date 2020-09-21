module AlchemyOrb
  class Engine < ::Rails::Engine
    isolate_namespace AlchemyOrb

    config.autoload_paths += Dir["#{config.root}/lib/**/"]
  end
end

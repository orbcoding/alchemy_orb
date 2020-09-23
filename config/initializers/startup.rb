AlchemyOrb::Config.load_user_config

# Engine
# before_init
AlchemyOrb::Engine.config.before_initialize do
	AlchemyOrb::ExtensionManager.load_extensions(
		glob: ['app', 'extensions_before_initialize', '**', '*_extension.rb'],
		engine: true,
	)
end

# to_prepare
AlchemyOrb::Engine.config.to_prepare do
	AlchemyOrb::ExtensionManager.load_extensions(
		glob: ['app', 'extensions', '**', '*_extension.rb'],
		engine: true,
	)

	AlchemyOrb::ViewComponentDelegator.delegate(engine: true)
end




# Application
# before_init
Rails.application.config.before_initialize do
	AlchemyOrb::ExtensionManager.load_extensions(
		glob: ['app', 'extensions_before_initialize', '**', '*_extension.rb']
	)
end

# to_prepare
Rails.application.config.to_prepare do
	AlchemyOrb::ExtensionManager.load_extensions(
		glob: ['app', 'extensions', '**', '*_extension.rb']
	)

	AlchemyOrb::ViewComponentDelegator.delegate
end


# Rails.autoloaders.main.ignore(AlchemyOrb::Engine.root.join('**', '_archive'))

# Dont run for rake tasks
exit if defined?(running_db_task?) && running_db_task?

AlchemyOrb::Config.load_user_config

# Engine
# before_init
AlchemyOrb::Engine.config.before_initialize do
	AlchemyOrb::ExtensionLoader.call(
		glob: ['app', 'extensions_before_initialize', '**', '*_extension.rb'],
		engine: true,
	)
end

# to_prepare
AlchemyOrb::Engine.config.to_prepare do
	AlchemyOrb::ExtensionLoader.call(
		glob: ['app', 'extensions', '**', '*_extension.rb'],
		engine: true,
	)

	AlchemyOrb::ViewComponentDelegator.call(engine: true)
end




# Application
# before_init
Rails.application.config.before_initialize do
	AlchemyOrb::ExtensionLoader.call(
		glob: ['app', 'extensions_before_initialize', '**', '*_extension.rb']
	)
end

# to_prepare
Rails.application.config.to_prepare do
	AlchemyOrb::ExtensionLoader.call(
		glob: ['app', 'extensions', '**', '*_extension.rb']
	)

	AlchemyOrb::ViewComponentDelegator.call
end


# Rails.autoloaders.main.ignore(AlchemyOrb::Engine.root.join('**', '_archive'))

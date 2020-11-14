Rails.application.config.assets.paths << AlchemyOrb::AssetPath.javascript

# Dont run rest for rake tasks
return if AlchemyOrb::RakeParser.running_task?

AlchemyOrb::Config.load_user_config

# Engine
# before_init
AlchemyOrb::Engine.config.before_initialize do
	AlchemyOrb::ElementFileMerger.call if AlchemyOrb::Config.get(:merge_element_files)

	AlchemyOrb::ExtensionPrepender.call(
		glob: ['app', 'extensions', '**', '*_extension_before_initialize.rb'],
		engine: true
	)
end

# to_prepare
AlchemyOrb::Engine.config.to_prepare do
	AlchemyOrb::ExtensionPrepender.call(
		glob: ['app', 'extensions', '**', '*_extension.rb'],
		engine: true,
	)

	AlchemyOrb::ViewComponentNamespacer.call(engine: true)
end

# Ignore **/_archive* files
ignore_files = Dir.glob(AlchemyOrb::Engine.root.join('app', '**', '_archive*'))
ignore_files += Dir.glob(AlchemyOrb::Engine.root.join('lib', '**', '_archive*'))
ignore_files += [ Rails.root.join('_docker'), Rails.root.join('_remote'), Rails.root.join('_gem_overrides') ]

if AlchemyOrb::Config.get(:zeitwerk_ignore_archive_folders)
	ignore_files += Dir.glob(Rails.root.join('app', '**', '_archive*'))
	ignore_files += Dir.glob(Rails.root.join('lib', '**', '_archive*'))
end

Rails.autoloaders.main.ignore(ignore_files)




# Application
# before_init
Rails.application.config.before_initialize do
	AlchemyOrb::ExtensionPrepender.call(
		glob: ['app', 'extensions', '**', '*_extension_before_initialize.rb']
	)
end

# to_prepare
Rails.application.config.to_prepare do
	AlchemyOrb::ExtensionPrepender.call(
		glob: ['app', 'extensions', '**', '*_extension.rb']
	)

	AlchemyOrb::ViewComponentNamespacer.call
end


# Rails.autoloaders.main.ignore(AlchemyOrb::Engine.root.join('**', '_archive'))

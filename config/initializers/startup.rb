# Dont run for rake tasks
return if AlchemyOrb::RakeParser.running_solo_task?

AlchemyOrb::Config.load_user_config

# Engine
# before_init
AlchemyOrb::Engine.config.before_initialize do
	AlchemyOrb::ElementFileMerger.call if AlchemyOrb::Config.get(:merge_element_files)

	AlchemyOrb::ExtensionPrepender.call(
		glob: ['app', 'extensions_before_initialize', '**', '*_extension.rb'],
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
if AlchemyOrb::Config.get(:zeitwerk_ignore_archive_folders)
	ignore_files = Dir.glob(Rails.root.join('**', '_archive*'))
	Rails.autoloaders.main.ignore(Dir.glob(Rails.root.join('**', '*_archive*')))
end




# Application
# before_init
# Rails.application.config.before_initialize do
# 	AlchemyOrb::ExtensionPrepender.call(
# 		glob: ['app', 'extensions_before_initialize', '**', '*_extension.rb']
# 	)
# end

# to_prepare
Rails.application.config.to_prepare do
	AlchemyOrb::ExtensionPrepender.call(
		glob: ['app', 'extensions', '**', '*_extension.rb']
	)

	AlchemyOrb::ViewComponentNamespacer.call
end


# Rails.autoloaders.main.ignore(AlchemyOrb::Engine.root.join('**', '_archive'))

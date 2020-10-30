AlchemyOrb::Config.set({
	# orb extensions
	prepend_extensions: true,
	# extensions/**extension/original/namespace_extension.rb
	prepend_user_extensions: true,
	# MyComponent => MyComponent::MyComponent
	apply_view_component_short_namespaces: true
	# AlchemyOrb.zeitwerk_ignore_underscore_archive_dirs
})

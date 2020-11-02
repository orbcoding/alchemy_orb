module AlchemyOrb::Config
  # Default config
  DEFAULT_CONFIG = {
    # orb extensions
    prepend_extensions: true,
    # extensions/**/ext/sub_folder/original/namespace_extension.rb
    # sub_folder can be eg controllers/models/helpers
    prepend_user_extensions: true,
    # MyComponent => MyComponent::MyComponent
    apply_view_component_short_namespaces: true,
		# zeitwerk_ignore_underscore_archive_dirs
		zeitwerk_ignore_archive_folders: true,
		# merge files Rails.root/config/alchemy/elements/_*elements.yml
		# _template_elements.yml contains eg: text: element_template...
		# Later used as contents: <t: ['text']
		merge_element_files: true
	}.freeze

	class << self
		def get(name)
			# check_deprecation(name)
			raise ArgumentError "Unknown config key #{name}" if !show.key?(name)
			show[name]
		end

		def set(config)
			config.keys.each do |key|
				raise ArgumentError, "Unknown config key: #{key}" if !DEFAULT_CONFIG.key?(key)
			end

			@config = show.merge(config)
		end

		def load_user_config
			path = "#{Rails.root}/config/alchemy_orb/config.rb"
			require(path) if File.exists?(path)
		end

		def show
			@config || DEFAULT_CONFIG
		end
	end
end

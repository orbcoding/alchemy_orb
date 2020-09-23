module AlchemyOrb

  class << self

    # def config=(config)
    #   (config).merge(config) do |key, val|
    #     ap "merging #{key}"
    #     raise "Unknown key: #{key}" if !@@DEFAULT_CONFIG.key?(key)
    #   end
    # end

    # def zeitwerk_ignore_underscore_archive_dirs
    #   Rails.autoloaders.main.ignore(Rails.root.join('**', '_archive'))
    # end
  end
end

require_relative "alchemy_orb/config"
require_relative "alchemy_orb/extension_manager"
require_relative "alchemy_orb/view_component_delegator"

# Require engine
require "alchemy_orb/engine"


module AlchemyOrb
end

# Runtime dependencies must also be listed here
require 'alchemy_cms'
require 'awesome_print'
require 'view_component'

require_relative "alchemy_orb/service"
require_relative "alchemy_orb/logger"
require_relative 'alchemy_orb/asset_path'
require_relative "alchemy_orb/config"
require_relative "alchemy_orb/extension_prepender"
require_relative "alchemy_orb/view_component_namespacer"
require_relative "alchemy_orb/element_file_merger"
require_relative "alchemy_orb/seed_parser"
require_relative "alchemy_orb/rake_parser"

AlchemyOrb.extend AlchemyOrb::Logger

# Require engine
require "alchemy_orb/engine"

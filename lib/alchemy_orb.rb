# Runtime dependencies must also be listed here
require 'alchemy_cms'
require 'awesome_print'
require 'view_component'

require_relative "alchemy_orb/logger"
require_relative "alchemy_orb/config"
require_relative "alchemy_orb/extension_prepender"
require_relative "alchemy_orb/view_component_namespacer"

# Require engine
require "alchemy_orb/engine"

module AlchemyOrb
	extend AlchemyOrb::Logger
end


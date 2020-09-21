$:.push File.expand_path("lib", __dir__)

# Maintain your gem's version:
require "alchemy_orb/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |spec|
  spec.name        = "alchemy_orb"
  spec.version     = AlchemyOrb::VERSION
  spec.authors     = ["Mikael Norlén"]
  spec.email       = ["mickenorlen@gmail.com"]
  spec.homepage    = "TODO"
  spec.summary     = "alchemy_cms extension"
  # spec.description = "TODO: Description of AlchemyOrb."
  spec.license     = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  spec.add_dependency "rails", "~> 6.0.3", ">= 6.0.3.2"
  spec.add_dependency "alchemy_cms", "~> 5.1.0", ">= 5.1.0"
  spec.add_dependency "awesome_print"

  spec.add_development_dependency "sqlite3"
end

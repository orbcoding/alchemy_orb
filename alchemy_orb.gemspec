$:.push File.expand_path("lib", __dir__)

# Maintain your gem's version:
require "alchemy_orb/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |gem|
  gem.name        = "alchemy_orb"
  gem.version     = AlchemyOrb::VERSION
  gem.authors     = ["Mikael Norlén"]
  gem.email       = ["mickenorlen@gmail.com"]
  gem.homepage    = "TODO"
  gem.summary     = "alchemy_cms extension"
  # gem.description = "TODO: Description of AlchemyOrb."
  gem.license     = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if gem.respond_to?(:metadata)
    gem.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  gem.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  gem.add_dependency "rails", "~> 6.0.3", ">= 6.0.3.2"
  gem.add_dependency "alchemy_cms"
  gem.add_dependency "awesome_print"

  gem.add_development_dependency "sqlite3"
end

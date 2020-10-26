$:.push File.expand_path("lib", __dir__)

# Maintain your gem's version:
require "alchemy_orb/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |gem|
  gem.name        = "alchemy_orb"
  gem.version     = AlchemyOrb::VERSION
  gem.authors     = ["Mikael Norlén"]
  gem.email       = ["mickenorlen@gmail.com"]
  # gem.homepage    = "TODO"
  gem.summary     = "alchemy_cms extension"
  # gem.description = "TODO: Description of AlchemyOrb."
  gem.license     = "MIT"
  gem.require_paths = ['lib']


  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if gem.respond_to?(:metadata)
    gem.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  gem.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  gem.add_runtime_dependency "rails", "~> 6.0.3", ">= 6.0.3.2"
  gem.add_runtime_dependency "alchemy_cms"
  gem.add_runtime_dependency "awesome_print"
  gem.add_runtime_dependency "view_component"


  gem.add_development_dependency 'rspec-rails',                  ['>= 4.0.0.beta2']
  gem.add_development_dependency 'bcrypt'
  # gem.add_development_dependency 'rspec-activemodel-mocks',      ['~> 1.0']
  gem.add_development_dependency "sqlite3"
  gem.add_development_dependency 'capybara',                     ['~> 3.0']
  # gem.add_development_dependency 'capybara-screenshot',          ['~> 1.0']
  gem.add_development_dependency 'factory_bot_rails',            ['~> 6.0']
  # gem.add_development_dependency 'puma',                         ['~> 5.0']
  # gem.add_development_dependency 'rails-controller-testing',     ['~> 1.0']
  # gem.add_development_dependency 'simplecov',                    ['~> 0.17.1']
  gem.add_development_dependency 'webdrivers',                   ['~> 4.0']
  # gem.add_development_dependency 'webmock',                      ['~> 3.3']
  # gem.add_development_dependency 'shoulda-matchers',             ['~> 4.0']

end

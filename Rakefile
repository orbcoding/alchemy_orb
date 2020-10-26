def running_tasks
  @running_tasks ||= Rake.application.top_level_tasks
end

def running_db_task?
  running_tasks.include?("db:create") ||
  running_tasks.include?("db:migrate") ||
  running_tasks.include?("db:setup") ||
  running_tasks.include?("db:drop")
end

begin
  require 'bundler/setup'
rescue LoadError
  puts 'You must `gem install bundler` and `bundle install` to run rake tasks'
end

require 'rdoc/task'

RDoc::Task.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'AlchemyOrb'
  rdoc.options << '--line-numbers'
  rdoc.rdoc_files.include('README.md')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

APP_RAKEFILE = File.expand_path("spec/dummy/Rakefile", __dir__)
load 'rails/tasks/engine.rake'

load 'rails/tasks/statistics.rake'

require 'bundler/gem_tasks'

# https://relishapp.com/rspec/rspec-core/v/3-8/docs/command-line/rake-task
begin
  require 'rspec/core/rake_task'
  RSpec::Core::RakeTask.new(:spec)
rescue LoadError
  # no rspec available
end

# Default test task
task default: [
  'alchemy_orb:spec:hide_warnings',
  :spec
]

namespace :alchemy_orb do
  namespace :spec do
    task :hide_warnings do
      ENV['RUBYOPT'] = '-W0'
    end

    desc "Prepares database for testing Alchemy"
    task :prepare do
      system(
        <<~BASH
          cd spec/dummy && \
          export RAILS_ENV=test && \
          bin/rake db:create && \
          bin/rake db:migrate && \
          cd -
        BASH
      ) || fail
    end
  end
end



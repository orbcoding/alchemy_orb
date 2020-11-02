namespace :alchemy_orb do
  namespace :db do
    namespace :seed do
      # Loads all seed files in seeds directory recursively as tasks
      # Supports param down eg: rails db:seed:dev[down]

      # Supports importing seed files
      #
      # AlchemyOrb::SeedParser.include_seeds([
      # 	'path_to_seed1',
      # 	'path_to_seed2',
      # ])
      Dir[Rails.root.join('db', 'seeds', '**', '*.rb')].each do |file_path|
        seed_path = file_path.split('/seeds/').last
        task_name = seed_path.remove('.rb').gsub('/', ':')
        desc "Seed " + task_name + ", based on file in `db/seeds/**/*.rb`"

        task task_name.to_sym, [:up_or_down] => :environment do |task, args|
          args.with_defaults(up_or_down: 'up')

          AlchemyOrb::SeedParser.seeding_down = args[:up_or_down] == 'down'
          AlchemyOrb::SeedParser.include_seeds([seed_path])
        end
      end
    end
  end
end

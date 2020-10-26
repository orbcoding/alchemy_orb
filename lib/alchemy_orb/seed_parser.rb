module AlchemyOrb::SeedParser
	@@seeding_down = false # If current seed is taken down

	extend self

	def seeding_down=(value)
		@@seeding_down = value
	end

	def seeding_down?
		return @@seeding_down
	end

	def seeding_up?
		return !seeding_down?
	end

	# UTILS
	def has_function?(file, function)
		(file =~ /^\s*[^#]*\s*def\s+#{function}\s*/).present?
	end

	# Include seeds in another seed
	def include_seeds(seed_paths, reverse_on_down = false)
		reversing_seeds = seeding_down? && reverse_on_down
		p = reversing_seeds ? seed_paths.reverse : seed_paths

		p.each do |seed_path|
			file_path = Rails.root.join('db', 'seeds', seed_path).to_s.gsub('.rb', '') + '.rb'

			if !File.exist?(file_path)
				puts "#{'not found'.red} #{seed_path}"
				exit
			end

			# Create temp file copy
			file = File.read(file_path)
			tmp = Tempfile.new(seed_path)
			tmp << file

			# Add up/down function call to temp file copy if defined
			if seeding_up? && has_function?(file, 'up')
				puts "#{"up".green} #{seed_path}"
				tmp.write "\nup"
			elsif seeding_down? && has_function?(file, 'down')
				puts "#{"down".red} #{seed_path}"
				tmp.write "\ndown"
			else
				puts "#{seeding_up? ? "parsing".green : "parsing".red} #{seed_path}"
			end

			# Save and load tmp file
			tmp.close
			begin
				load(tmp.path)
			rescue Exception => e # Point backtrace to original file, and quit all iterations
				if !defined?(@@failed)
					@@failed = true
					puts e
					last_tmp_backtrace_index = e.backtrace.length - e.backtrace.reverse.index{|x| x.include?(tmp.path)} - 1
					puts e.backtrace[0..last_tmp_backtrace_index].map{|x| x.gsub(tmp.path, file_path)}
				end
			end
			exit if defined?(@@failed)
		end
	end
end

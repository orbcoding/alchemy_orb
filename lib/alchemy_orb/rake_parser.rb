module AlchemyOrb::RakeParser
	extend self

	def running_tasks
		@running_tasks ||= Rake.const_defined?('Application') ? Rake.application.top_level_tasks : nil
	end

	def running_generator?
		defined? Rails::Generators
	end

	def running_task?
		# ap defined? Rails::Generators
		running_tasks || running_generator?
	end

	def running_db_task?
		running_tasks&.detect{|task|
			task.include?('db:') ||
			task.include?("assets:") ||
			task.include?("webpacker:")
		}
	end
end

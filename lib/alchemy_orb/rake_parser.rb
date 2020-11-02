module AlchemyOrb::RakeParser
	extend self

	def running_tasks
		@running_tasks ||= Rake.const_defined?('Application') ? Rake.application.top_level_tasks : nil
	end

	def running_db_task?
		running_tasks && (
			running_tasks.include?("db:create") ||
			running_tasks.include?("db:migrate") ||
			running_tasks.include?("db:setup") ||
			running_tasks.include?("db:drop")
		)
	end
end

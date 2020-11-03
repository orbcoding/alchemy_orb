module AlchemyOrb::RakeParser
	extend self

	def running_tasks
		@running_tasks ||= Rake.const_defined?('Application') ? Rake.application.top_level_tasks : nil
	end

	def running_solo_task?
		running_tasks && (
			running_tasks.include?("db:") ||
			running_tasks.include?("assets:") ||
			running_tasks.include?("webpacker:")
		)
	end
end

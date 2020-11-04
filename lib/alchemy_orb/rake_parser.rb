module AlchemyOrb::RakeParser
	extend self

	def running_tasks
		@running_tasks ||= Rake.const_defined?('Application') ? Rake.application.top_level_tasks : nil
	end

	def running_solo_task?
		running_tasks&.detect{|task|
			task.include?('db:') ||
			task.include?("assets:") ||
			task.include?("webpacker:")
		}
	end
end

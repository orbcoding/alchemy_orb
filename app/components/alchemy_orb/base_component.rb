class AlchemyOrb::BaseComponent < ViewComponent::Base
	include AlchemyOrb::BaseHelper

	def helpers
		(super rescue Current.helpers) || Current.helpers
	end

	def render_template(name, is_partial = true)
		auto_fill_exts = ['html.erb', 'js.erb']

		name = "_#{name}" if is_partial

		if @component_path.nil?
			call_file = caller[0][/[^:]+/]
			@component_path = File.dirname(call_file)
		end

		file_path = "#{@component_path}/#{name}"

		if File.file?(file_path)
			final_path = file_path
		else
			auto_fill_exts.each do |ext|
				new_path = "#{file_path}.#{ext}"

				if File.file?(new_path)
					final_path = new_path
					break
				end
			end
		end

		raise "#{name} not found in #{@component_path}, tried exts #{auto_fill_exts}" if !final_path

		file = File.open(final_path).read
		template = ERB.new(file)
		template.result(self.binding).html_safe
	end
end

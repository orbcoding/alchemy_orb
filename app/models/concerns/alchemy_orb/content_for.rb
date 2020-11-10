module AlchemyOrb::ContentFor
	extend ActiveSupport::Concern

	included do
		# Implement content_for in controller
		# Needs to be run on include to controller so view_context doesn't cache in module and super loop itself
		def view_context
			super.tap do |view|
				(@_content_for || {}).each do |name,content|
					view.content_for(name, content)
				end
			end
		end

		def content_for(name, content = nil, &block) # no blocks allowed yet
			content = capture(&block) if block_given?
			@_content_for ||= {}
			if @_content_for[name].respond_to?(:<<)
				@_content_for[name] << content
			else
				@_content_for[name] = content
			end
		end

		def content_for?(name)
			@_content_for[name].present?
		end
	end
end

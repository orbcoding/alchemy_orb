class AlchemyOrb::ElementComponentFinder
	def initialize(element:)
		@element = element
		find_namespace
		ap @namespace
	end

	def namespace
		@namespace
	end

	def new(**args)
		@namespace.constantize.new(element: @element, **args)
	end

	def config
		Object.const_defined?("#{@namespace}::Config") ?
			"#{@namespace}::Config".constantize.new(element: element) :
			nil
	end

	private

	def find_namespace
		if AlchemyElement.const_defined?("#{@element.name}_component".classify)
			# Standard location
			@namespace = "alchemy_element/#{@element.name}_component".classify
		else
			split = @element.name.split('_')
			prev = ''
			split.each do |p|
				folder_space = (prev.present? ? "#{prev}_#{p}" : p).classify
				if AlchemyElement.const_defined?(folder_space)
					@namespace = "alchemy_element/#{folder_space}/#{@element.name}_component".classify
					break
				end
			end
		end
	end
end

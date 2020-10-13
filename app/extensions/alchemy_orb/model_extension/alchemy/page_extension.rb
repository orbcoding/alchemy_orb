module AlchemyOrb::ModelExtension::Alchemy::PageExtension
	def view_component
		Struct.new(:page, :namespace) do
			def new
				namespace.constantize.new(page: page)
			end

			def config
				Object.const_defined?("#{namespace}::Config") ?
					"#{namespace}::Config".constantize.new(page: page) :
					AlchemyOrb::Alchemy::PageComponent::Config.new(page: page)
			end
		end.new(
			self,
			"alchemy/page/#{layout_partial_name}_component".classify
		)
	end

	def to_partial_path
		"alchemy/page_layouts/redirect_page_to_component"
	end
end

module AlchemyOrb::ModelExtension::Alchemy::PageExtension
	def view_component
		AlchemyOrb::PageComponentFinder.new(page: self)
	end

	def to_partial_path
		"alchemy/page_layouts/redirect_page_to_component"
	end
end

class AlchemyOrb::AlchemyAdmin::PagePropertiesComponent::PagePropertiesComponent < AlchemyOrb::AlchemyAdminComponent
  def initialize(page_properties)
    @page_properties = page_properties || { fields: {}}
  end

  def render?
    @page_properties.present?
  end
end

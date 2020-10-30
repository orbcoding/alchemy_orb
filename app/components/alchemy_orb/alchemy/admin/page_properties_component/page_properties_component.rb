class AlchemyOrb::Alchemy::Admin::PagePropertiesComponent::PagePropertiesComponent < AlchemyOrb::Alchemy::AdminComponent
  def initialize(page_properties)
    @page_properties = page_properties || { fields: {}}
  end

  def render?
    @page_properties.present?
  end
end

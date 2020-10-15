class AlchemyOrb::Alchemy::Admin::PreviewPageSelectionComponent::PreviewPageSelectionComponent < AlchemyOrb::Alchemy::AdminComponent
  def initialize(selections = nil)
    return if !selections

    @selections = selections
    @collection = selections.map{|s| [s[:label], s[:name]]}
  end

  def render?
    @selections.present?
  end
end

class AlchemyOrb::Alchemy::Admin::ConfirmPublishComponent::ConfirmPublishComponent < AlchemyOrb::Alchemy::AdminComponent
  def initialize(page:)
    @page = page

    config = @page.view_component.config
    @fields = config.confirm_publish_fields.sort_by{|e| e[:position]}
    @help_texts = config.confirm_publish_help_texts.sort_by{|e| e[:position]}
    # @component = @page.view_component
  end

  def fields_error?
    @fields.any?{|field| field[:error]}
  end
end

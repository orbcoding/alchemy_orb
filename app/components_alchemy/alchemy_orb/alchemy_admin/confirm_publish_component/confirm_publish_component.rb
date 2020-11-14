class AlchemyOrb::AlchemyAdmin::ConfirmPublishComponent::ConfirmPublishComponent < AlchemyOrb::AlchemyAdminComponent
  def initialize(page:)
    @page = page

    config = @page.view_component.config.confirm_publish
    @fields = config[:fields].sort_by{|_k, v| v[:position]}.to_h
    @help_texts = config[:help_texts].sort_by{|_k, v| v[:position]}.to_h
  end

  def fields_error?
    @fields.any?{|k, v| v[:error]}
  end
end

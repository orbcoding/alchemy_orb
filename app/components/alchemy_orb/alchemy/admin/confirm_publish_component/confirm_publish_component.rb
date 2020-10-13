class AlchemyOrb::Alchemy::Admin::ConfirmPublishComponent::ConfirmPublishComponent < AlchemyOrb::Alchemy::AdminComponent
  def initialize(page:)
    @page = page
    # @component = @page.view_component
  end

  def default_fields
    @default_fields ||= [
      {
        name: 'title',
        position: 10,
        label: 'Title',
        value: @page.title,
        error: !@page.title,
      },
      {
        name: 'description',
        position: 20,
        label: 'Description',
        value: @page.meta_description,
        error: !@page.layoutpage && !@page.meta_description
      },
      {
        name: 'urlname',
        position: 30,
        label: Alchemy::LegacyPageUrl.human_attribute_name(:urlname),
        value: "/#{@page.urlname}"
      },
    ]
  end

  def page_fields
    @page_fields ||= @component &.confirm_publish || {}
  end

  def fields
    @fields ||= begin
      merged_page_fields = page_fields.map do |field|
        default_field = default_fields.detect{|f| f[:name] == field[:name]}
        default_field ? default_field.merge(field) : field
      end

      merged_fields = (merged_page_fields + default_fields).uniq{|e| e[:name].to_s}

      merged_fields.sort_by{|h| h[:position]}
    end
  end

  def fields_error?
    fields.any?{|field| field[:error]}
  end

  def page_help_texts
    @page_fields ||= @component &.confirm_publish_help_texts || {}
  end

  def default_help_texts

  end

  def help_texts
    [
      {
        name: 'screen_sizes',
        title: 'Different screen sizes',
        description: 'Use "Preview size" to check the page in different screen sizes, especially if you are using wide images.
          Wide images are often cropped to fit better in smaller screens. You can use the image gravity property to change the crop focus.'
      },
    ]
  end
end

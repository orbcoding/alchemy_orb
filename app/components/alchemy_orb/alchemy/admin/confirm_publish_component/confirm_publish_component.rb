class AlchemyOrb::Alchemy::Admin::ConfirmPublishComponent::ConfirmPublishComponent < AlchemyOrb::AlchemyAdminComponent
  include AlchemyHelper

  def initialize(page:)
    @page = page
    set_meta
  end

  def errors
    @errors ||= {
      title: @title.blank?,
      description: @page.layoutpage ? false : @description.blank?
    }
  end

  def has_errors
    @has_errors ||= errors.values.any?
  end

  private

  def set_meta
    if @page.page_layout == 'blog_post'
      post_base = @page.elements.named(:blog_post_base).first

      if post_base.present?
        h = element_view_helper_for(post_base)
        @title = h.essence(:blog_post_title).stripped_body
        @description = h.essence(:blog_post_description).stripped_body
        @image = h.essence(:blog_post_image) &.ingredient &.image_file_name
      end
    else
      @description = @page.meta_description
      @title = @page.title
    end
  end
end

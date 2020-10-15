class AlchemyOrb::Alchemy::PageComponent::Config
	include AlchemyOrb::AlchemyHelper

	def initialize(page:)
		@page = page
		# Initialize hook for subclasses
		post_initialize if defined? post_initialize
	end


	# Page meta tags
	# Title, title_prefix, description and image will fall back to site identity if nil here
	def page_meta
		{
			title: @page.title || '',
			title_prefix: nil,
			description: meta_description,
			image: nil,
			language_code: @page.language_code,
			keywords: meta_keywords,
			created: @page.updated_at,
			meta_robots: meta_robots
		}
	end

	# eg [ 'title', 'description' ]
	def hidden_page_properties
	end

	# Which fields will be confirmed
	def confirm_publish_fields
		[
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

	# Which help texts to show
	def confirm_publish_help_texts
    [
      {
				name: 'screen_sizes',
				position: 10,
        title: 'Different screen sizes',
				description: 'Use "Preview size" to check the page in different screen sizes.'
			},
			{
				name: 'gravity',
				position: 20,
        title: 'Gravity',
        description: 'Wide images such as banners are cropped to fit better in smaller screens. You can adjust their crop focus by changing gravity in picture properties.'
			},
    ]
	end

	# Which preview pages to select EG:
	# [
	# 	{
	# 		name: 'blog_post',
	# 		label: Alchemy.t('Post'),
	# 		src: Alchemy::Engine.routes.url_helpers.admin_page_path(@page)
	# 	},
	# 	{
	# 		name: 'blog_posts',
	# 		label: Alchemy.t('Blog list'),
	# 		src: Alchemy::Engine.routes.url_helpers.admin_page_path(@page, preview_page: @page.parent)
	# 	}
	# ]
	def preview_page_selection
	end
end

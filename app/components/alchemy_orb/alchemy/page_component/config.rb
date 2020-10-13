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

	# Which fields will be confirmed
	def confirm_publish_fields

	end

	# Which help texts to show
	def confirm_publish_help_texts

	end
end

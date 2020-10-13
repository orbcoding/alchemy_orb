class AlchemyOrb::PageMetaComponent::PageMetaComponent < ApplicationComponent
	# page is defined if alchemy page, otherwise page_config
	# Anything defined in page_meta will get priority
	# page_meta is also retrieved from AlchemyPageComponents
	def initialize(page:, page_meta:)
		@page_meta = if page
			meta = page.view_component &.config &.page_meta
		else
			page_meta || {}
		end


		ap 'config'
		ap page
		ap page.view_component &.config

		@page_meta = {} if !@page_meta

		ap 'page_meta'
		ap @page_meta
	end

	def title
		title = @page_meta[:title] || helpers.render_elements(from_page: 'identity', only: 'identity_title')
		title_prefix ? "#{title_prefix}#{title}" : title
	end

	def title_prefix
		@page_meta[:title_prefix] || helpers.render_elements(from_page: 'identity', only: 'identity_title_prefix')
	end

	def description
		@page_meta[:description] || helpers.render_elements(from_page: 'identity', only: 'identity_description')
	end

	def image
		@page_meta[:image] || helpers.render_elements(from_page: 'identity', only: 'identity_image', only_href: true).squish
	end

	def language_code
		@page_meta[:language_code]
	end

	def keywords
		@page_meta[:keywords]
	end

	def created
		@page_meta[:created]
	end

	def robots
		@page_meta[:robots]
	end
end

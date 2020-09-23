class AlchemyOrb::PageMetaComponent::PageMetaComponent < ApplicationComponent
	# page is defined if alchemy page, otherwise page_config
	def initialize(page:, page_meta:)
		@page = page
		@page_meta = page_meta || {}
		@overrides = {}

		set_overrides if defined? set_overrides
	end

	def set_overrides
		ap 'inner'
	end

	def language_code
		@page ? @page.language_code : @page_meta[:language_code]
	end

	def title
		return @overrides[:title] if @overrides[:title]
		if @page
			helpers.page_title(prefix: @page_meta[:title_prefix], suffix: @page_meta[:title_suffix], separator: @page_meta[:title_separator])
		else
			@page_meta[:title] || helpers.render_elements(from_page: 'identity', only: 'identity_title')
		end
	end

	def description
		return @overrides[:description] if @overrides[:description]
		return helpers.meta_description if @page
		@page_meta[:description] || helpers.render_elements(from_page: 'identity', only: 'identity_description')
	end

	def image
		(@overrides[:image] || helpers.render_elements(from_page: 'identity', only: 'identity_image', only_href: true)).squish
	end

	def keywords
		@page ? helpers.meta_keywords : @page_meta[:keywords]
	end

	def created
		@page ? @page.updated_at : @page_meta[:created]
	end

	def robots
		@page ? helpers.meta_robots : @page_meta[:robots]
	end
end

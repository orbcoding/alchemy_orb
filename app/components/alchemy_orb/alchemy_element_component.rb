class AlchemyOrb::AlchemyElementComponent < BaseComponent
	delegate :render, to: :helpers

	# include Alchemy::PagesHelper
	include AlchemyHelper

	def initialize(element:, page:, preview_mode:, options:, counter:)
		@element = element
		@page = page# Also in Current.alchemy_edit_page if in edit
		@preview_mode = preview_mode # Also in Current.alchemy_preview_mode
		@options = options
		@counter = counter
		# @locals = locals No point for now

		# Initialize hook for subclasses
		post_initialize if defined? post_initialize
	end

	def custom_cache
		false
	end
end

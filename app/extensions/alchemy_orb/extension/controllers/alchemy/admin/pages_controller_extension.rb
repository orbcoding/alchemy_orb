module AlchemyOrb::Extension::Controllers::Alchemy::Admin::PagesControllerExtension
	def self.prepended(base)
	end

	def edit
		content_for :javascripts, "<script>#{view_context.render("edit_global.js")}</script>".html_safe

		if @page.page_layout == 'blog_post'
			include_script
		end

		super
	end

	def show
		Current.alchemy_edit_page = @page
		Current.alchemy_preview_mode = true
		if params[:show_list] && @page.page_layout == 'blog_post'
			# @page_layout = 'no_menus'
			@page = @page.parent
		end

		super
	end

	def info
		if params[:confirm_publish]
			render Alchemy::Admin::ConfirmPublishComponent.new(page: @page)
		else
			super
		end
	end

	private

	def include_script
		content_for :javascripts, "<script>#{view_context.render("edit_#{@page.page_layout}.js")}</script>".html_safe
	end
end

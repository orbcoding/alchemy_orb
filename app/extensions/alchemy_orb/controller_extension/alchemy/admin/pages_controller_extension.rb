module AlchemyOrb::ControllerExtension::Alchemy::Admin::PagesControllerExtension
	def self.prepended(base)
	end

	def edit
		content_for :javascripts, "<script>#{view_context.render("alchemy/admin/pages/edit_global.js")}</script>".html_safe

		include_page_edit_script(@page.page_layout)

		super
	end

	def show
		Current.alchemy_edit_page = @page
		Current.alchemy_preview_mode = true

		if params[:preview_page]
			@page = Alchemy::Page.find(params[:preview_page])
		end

		super
	end

	def info
		if params[:confirm_publish]
			render AlchemyOrb::Alchemy::Admin::ConfirmPublishComponent.new(page: @page)
		else
			super
		end
	end

	private

	# Includes page specific script if exists in:
	# views/alchemy/admin/pages/_edit_#{page_layout}
	def include_page_edit_script(page_layout)
		if lookup_context.exists?("edit_#{page_layout}.js", ["alchemy/admin/pages"], true)
			content_for :javascripts, "<script>#{view_context.render("edit_#{page_layout}.js")}</script>".html_safe
		end
	end
end

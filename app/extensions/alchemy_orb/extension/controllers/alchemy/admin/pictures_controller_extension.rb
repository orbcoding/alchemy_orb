module AlchemyOrb::Extension::Controllers::Alchemy::Admin::PicturesControllerExtension
	def index
		content_for :javascripts, "<script>#{view_context.render(Alchemy::Admin::UploadOptimizationSelectComponent.new)}</script>".html_safe

		super
	end

	def create
		Current.alchemy_upload_image_optimization = params[:upload_image_optimization]

		super
	end
end

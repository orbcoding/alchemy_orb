class AlchemyOrb::Alchemy::Admin::UploadOptimizationSelectComponent::UploadOptimizationSelectComponent < AlchemyOrb::Alchemy::AdminComponent
	def initialize(in_pages_edit: false)
		@in_pages_edit = in_pages_edit
	end

	def titles
		{
			optimize: 'Optimize images for web resized to max width 1920px. Almost always recommended',
			optimize_large: 'Optimize images for web resized to max width 2880px. Gives more space for cropping large images.',
			optimize_keep_format: 'If you need png for transparent background, try this option for experimental png compression',
			unoptimize: 'Optimize without loss of quality'
		}
	end

	def selection
		selection = j select_tag(
			'upload_image_optimization_select',
			options_for_select([
				[ "Optimize uploads &nbsp;&#10004;".html_safe, { title: titles[:optimize] }, "optimize" ],
				[ "Optimize large &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&#9432;".html_safe, { title: titles[:optimize_large] }, "optimize_large" ],
				[ "Keep png format &nbsp;&nbsp;&#9432;".html_safe, { title: titles[:optimize_keep_format] }, "optimize_keep_format" ],
				[ "Original quality &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&#10071;".html_safe, { title: titles[:unoptimize] }, "unoptimize"]
			]),
			class: 'alchemy_selectbox_no_select2',
			title: titles[:optimize]
		)
	end


end

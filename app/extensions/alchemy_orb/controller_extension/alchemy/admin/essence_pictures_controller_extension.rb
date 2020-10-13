module AlchemyOrb::ControllerExtension::Alchemy::Admin::EssencePicturesControllerExtension

	def crop
		super

		# Fix for allowing cropping tool when width/height is same as image
		# While still restricting/blocking crop area size
		# Works in tandem with Picture::TransformationsExtension#is_bigger_than
		if @picture && @min_size
			@min_size[:width] = @min_size[:width] - 1 if @picture.image_file_width == @min_size[:width]
			@min_size[:height] = @min_size[:height] - 1 if @picture.image_file_height == @min_size[:height]
		end
	end

	def update
		if essence_picture_params[:render_size] &&
			(essence_picture_params[:render_size] != @essence_picture.render_size)
			@essence_picture.crop_from = ''
			@essence_picture.crop_size = ''
		end

		# Skip presence validation when updating properties
		@essence_picture.skip_presence_validation = true if essence_picture_params[:alt_tag]

		super
	end
end

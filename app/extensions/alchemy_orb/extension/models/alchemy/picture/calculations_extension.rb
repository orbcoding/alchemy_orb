# Included in Picture
module AlchemyOrb::Extension::Models::Alchemy::Picture::CalculationsExtension
	def is_bigger_than(dimensions)
		# Fix to allow cropping tool when image size is equal to wanted.
		# Works in tandem with Alchemy::Admin::EssencePicturesControllerExtension
		image_file_width >= dimensions[:width] && image_file_height >= dimensions[:height]
	end
end

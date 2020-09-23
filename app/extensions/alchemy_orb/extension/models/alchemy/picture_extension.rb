module AlchemyOrb::Extension::Models::Alchemy::PictureExtension
	# include AlchemyOrb::Extension::Models::Alchemy::Picture::CalculationsExtension

	# Adjust dragonfly image processing
	def self.prepended(base)
		base.send :dragonfly_accessor, :image_file, app: :alchemy_pictures do

			# Preprocess after uploading the picture
			after_assign do |p|
				opt_info = AlchemyOrb::ImageOptimizer.new(
					picture: p,
					format: image_file_format,
					optimization: Current.alchemy_upload_image_optimization,
					convertible_format: has_convertible_format?
				).optimize

				self.assign_attributes(image_file: opt_info[:new_image]) if opt_info[:new_image]
				self.assign_attributes(optimization: opt_info[:optimization]) if opt_info[:optimization]
			end
		end
	end
end

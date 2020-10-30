# Included in picture
module AlchemyOrb::ModelExtension::Alchemy::PictureVariantExtension
	def encoded_image(image, options = {})
		image = super

		target_format = options[:format] || picture.default_render_format

		if target_format == 'png' && picture.optimization &.split(',') &.include?('pngquant')
			image.steps.push(Dragonfly::Job::Process.new(image, :pngquant))
		end

		image
	end

	# def encoded_image(image, options = {})
	# 	target_format = options[:format] || default_render_format

	# 	unless target_format.in?(Alchemy::Picture.allowed_filetypes)
	# 		raise WrongImageFormatError.new(self, target_format)
	# 	end

	# 	options = {
	# 		flatten: target_format != "gif" && image_file_format == "gif",
	# 	}.with_indifferent_access.merge(options)

	# 	encoding_options = []

	# 	if target_format =~ /jpe?g/
	# 		quality = options[:quality] || Config.get(:output_image_jpg_quality)
	# 		encoding_options << "-quality #{quality}"
	# 	end

	# 	if options[:flatten]
	# 		encoding_options << '-flatten'
	# 	end

	# 	convertion_needed = target_format != image_file_format || encoding_options.present?

	# 	if has_convertible_format? && convertion_needed
	# 		image = image.encode(target_format, encoding_options.join(' '))
	# 	end

	# 	image
	# end
end

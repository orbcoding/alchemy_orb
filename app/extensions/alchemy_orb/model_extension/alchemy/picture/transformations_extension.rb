# skip_prepend: true
module AlchemyOrb::ModelExtension::Alchemy::Picture::TransformationsExtension
	def default_mask(mask_arg, to_points = true)
		mask = mask_arg.dup

		if mask[:width].zero? || mask[:height].zero?
			mask[:width] = image_file_width
			mask[:height] = image_file_height
		end

		crop_size = size_when_fitting({width: image_file_width, height: image_file_height}, mask)
		top_left = get_top_left_crop_corner(crop_size)

		to_points ? point_and_mask_to_points(top_left, crop_size) : [top_left, crop_size]
  end

  # Converts a dimensions hash to a string of from "20x20"
  #
  def dimensions_to_string(dimensions)
    super.gsub('x0', '');
  end

  # Returns a size value String for the thumbnail used in essence picture editors.
  #
  def thumbnail_size(size_string = "0x0", crop = false)
    size = sizes_from_string(size_string)

    # only if crop is set do we need to actually parse the size string, otherwise
    # we take the base image size.
    if crop
      if size[:width].zero? || size[:height].zero?
        size[:width] = get_base_dimensions[:width]
        size[:height] = get_base_dimensions[:height]
      end

      size = reduce_to_image(size)
    else
      size = get_base_dimensions
    end

    size = size_when_fitting({width: Alchemy::Picture::Transformations::THUMBNAIL_WIDTH, height: Alchemy::Picture::Transformations::THUMBNAIL_HEIGHT}, size)
    "#{size[:width]}x#{size[:height]}"
  end
end

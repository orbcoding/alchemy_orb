module AlchemyOrb::Extension::Models::Alchemy::EssencePictureViewExtension
	# Workaround to get private methods
	def get_srcset
		srcset.join(', ').presence
	end

	def get_img_tag
		img_tag
	end

	def get_caption
		caption
	end

	def get_is_linked?
		is_linked?
	end

	def get_picture_url
		essence.picture_url(options.except(*Alchemy::EssencePictureView::DEFAULT_OPTIONS.keys))
	end
end

# Current attributes available anywhere and reset for each request
module AlchemyOrb
	class Current < ActiveSupport::CurrentAttributes
		attribute :alchemist,
			:alchemy_edit_page,
			:alchemy_preview_mode,
			:alchemy_upload_image_optimization,
			:helpers
	end
end

class AlchemyOrb::Alchemy::Admin::ConfirmPublishComponent::Button < AlchemyOrb::Alchemy::AdminComponent
	def initialize(page:, prev_btn_id:, replace_parent:)
		@page = page
		@prev_btn_id = prev_btn_id
		@replace_parent = replace_parent
	end
end

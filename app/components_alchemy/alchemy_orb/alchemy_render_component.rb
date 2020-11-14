class AlchemyOrb::AlchemyRenderComponent < AlchemyOrb::BaseComponent
	delegate :render, to: :helpers

	include AlchemyOrb::AlchemyHelper
end

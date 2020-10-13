# Included in Alchemy::ElementExtension
module AlchemyOrb::ModelExtension::Alchemy::Element::ElementContentsExtension
	def update_contents(contents_attributes)
		if contents_attributes.present?
			contents.each do |content|
				content.essence.contents_attributes = contents_attributes
			end
		end

		super
	end
end

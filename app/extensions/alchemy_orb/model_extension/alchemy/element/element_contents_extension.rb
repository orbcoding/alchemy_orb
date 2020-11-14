# skip_prepend: true
# Included in Alchemy::ElementExtension
module AlchemyOrb::ModelExtension::Alchemy::Element::ElementContentsExtension
	def update_contents(contents_attributes)
		if contents_attributes.present?
			contents.each do |content|
				# Pass contents_attributes to essence for cross validation
				content.essence.contents_attributes = contents_attributes

				# Set default alt text to picture human filename
				content_hash = contents_attributes[content.id.to_s]
				if content_hash["picture_id"].present?
					alt_tag = Alchemy::Picture.find(content_hash["picture_id"])&.name&.humanize
					content_hash['alt_tag'] = alt_tag
				end
			end
		end

		super
	end
end

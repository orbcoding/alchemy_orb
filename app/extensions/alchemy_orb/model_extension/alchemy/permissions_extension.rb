module AlchemyOrb::ModelExtension::Alchemy::PermissionsExtension
	module AuthorUser
		def alchemy_author_rules
			super
			cannot :index, [
				:alchemy_admin_nodes,
				:alchemy_admin_layoutpages
			]
		end
	end

	module EditorUser
		def alchemy_editor_rules
			super
			cannot :index, [
				:alchemy_admin_languages,
			]

			can :index, [
				:alchemy_admin_layoutpages,
				:alchemy_admin_nodes,
			]
		end
	end

	module AdminUser
		def alchemy_admin_rules
			super
			can :index, [
				:alchemy_admin_languages,
			]
		end
	end

	include AuthorUser
	include EditorUser
	include AdminUser
end

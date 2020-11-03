module AlchemyOrb::ControllerExtension::Alchemy::Admin::BaseControllerExtension
	include Shared::ContentFor

	def self.prepended(base)
		base.before_action :inject_admin_assets
	end

	def inject_admin_assets
		# Needed for loading separated stylesheet
		content_for :stylesheets, view_context.stylesheet_pack_tag('alchemy/admin', media: 'all', 'data-turbolinks-track': 'reload')
	# 	content_for :javascript_includes, view_context.javascript_pack_tag('alchemy/admin', 'data-turbolinks-track': 'reload')
	end
end

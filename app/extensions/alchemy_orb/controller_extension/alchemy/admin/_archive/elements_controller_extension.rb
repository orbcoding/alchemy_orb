module Alchemy::Admin::ElementsControllerExtension
	def update
		super

		# u = render_to_string(action: 'update')
		# u_ext = render_to_string('_update_extension')

		# render js: u + u_ext
	end
end

Alchemy::Admin::ElementsController.prepend(Alchemy::Admin::ElementsControllerExtension)

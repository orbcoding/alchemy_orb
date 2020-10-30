# skip_prepend: true
# Is included in admin pages_controller to
module AlchemyOrb::HelperExtension::Alchemy::Admin::PagesHelperExtension
	def preview_sizes_for_select
		options_for_select([
			'auto',
			[Alchemy.t('320', scope: 'preview_sizes'), 320],
			[Alchemy.t('480', scope: 'preview_sizes'), 480],
			[Alchemy.t('768', scope: 'preview_sizes'), 768],
			[Alchemy.t('1024', scope: 'preview_sizes'), 1024],
			[Alchemy.t('1280', scope: 'preview_sizes'), 1280]
		])
	end
end

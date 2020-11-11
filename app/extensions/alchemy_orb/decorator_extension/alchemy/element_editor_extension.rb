module AlchemyOrb::DecoratorExtension::Alchemy::ElementEditorExtension
	def css_classes
		classes = super
		classes += ' compact compact-wide' if definition["compact"] == 'wide'
		classes += ' compact compact-wide foldable' if definition["compact"] == 'wide_foldable'

		classes
	end
end

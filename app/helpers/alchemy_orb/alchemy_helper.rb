module AlchemyOrb::AlchemyHelper
	include Alchemy::PagesHelper

	def present_element_view_for(element, opts = {}, &block)
		unless klass = opts.delete(:p)
			klass = "#{element.name.camelize}Presenter".constantize
		end

		element_view_for(element, opts) do |el|
			presenter = klass.new(el, self)
			block.call(presenter)
		end
	end

	def element_view_helper_for(element)
		Alchemy::ElementsBlockHelper::ElementViewHelper.new(self, element: element)
	end

	def element_view_attributes_for(element, options = {})
		opts = {
			id: element_dom_id(element),
			# tags_formatter: ->(tags) { tags.join(" ") },
			class: element.name
		}.merge(options)

		# if tags_formatter = options.delete(:tags_formatter)
		# 	options.merge!(element_tags_attributes(element, formatter: tags_formatter))
		# end

		# .merge(element_tags_attributes(element, formatter: tags_formatter))
		opts = opts
		.merge!(element_preview_code_attributes(element))

		opts
	end
end

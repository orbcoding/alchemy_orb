module AlchemyOrb::ViewComponentDelegator
	extend self

	# MyComponent => MyComponent::MyComponent
	def call(engine: false)
		puts "[AlchemyOrb] Delegating#{engine ? ' engine' : ' user'} view_component shorthand namespaces"
		Dir.glob(root(engine).join('app', 'components', '**', '*_component', '*_component.rb'))
			.reject{|f| f.include?('_archive')}
			.each do |f|
				apply_shorthand(f, engine)
		end
	end


	private

	def root(engine = false)
		engine ? AlchemyOrb::Engine.root : Rails.root
	end

	def apply_shorthand(file, engine)
		folder_path = File.dirname(file)
		folder_rel_path = Pathname.new( folder_path ).relative_path_from( Pathname.new( root(engine).join('app', 'components') ) ).to_s
		folder_namespace = folder_rel_path.classify
		component_class_name = folder_namespace.demodulize

		parent_module = folder_namespace.include?('::') ?
			folder_namespace.split('::')[0...-1].join('::').constantize :
			Object

		component_module = "#{folder_namespace}::#{component_class_name}".constantize

		# What we do here
		#
		# 1. Cache constants
		# my_component_my_component_clone = MyComponent::MyComponent
		# my_component_nested_cached = MyComponent::Nested
		#
		# 2. Delete folder namespace module with nested constants
		# MyComponent (deleted)
		#
		# 3. Reassign cached constants to folder namespace
		# MyComponent = my_component_my_component_clone
		# MyComponent::Nested = my_component_nested_cached

		component_clone = component_module.clone

		nested_files = Dir.entries(folder_path).select{|path|
				File.extname(path) == '.rb' &&
				# Excluding component file which is already cloned
				!File.basename(path).include?(component_class_name.underscore)
			}

		nested_modules = nested_files.map do |path|
			file_class_name = File.basename(path, '.rb').classify
			"#{folder_namespace}::#{file_class_name}".constantize
		end

		# Remove folder module and assign the nested class clone instead
		parent_module.send(:remove_const, component_class_name)
		parent_module.send(:const_set, component_class_name, component_clone)

		# Reassign nested modules to class clone at folder namespace
		nested_modules.each do |nested_module|
			folder_namespace.constantize.const_set(nested_module.to_s.demodulize, nested_module)
		end
	end
end

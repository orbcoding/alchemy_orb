module AlchemyOrb::ViewComponentDelegator
  class << self
    def root(engine = false)
      engine ? AlchemyOrb::Engine.root : Rails.root
    end

    # MyComponent => MyComponent::MyComponent
    def delegate(engine: false)
      puts "[AlchemyOrb] Delegating#{engine ? ' engine' : ' user'} view_component shorthand namespaces"
      Dir.glob(root(engine).join('app', 'components', '**', '*_component', '*_component.rb')).each do |f|
        apply_shorthand(f, engine)
      end
    end

    def apply_shorthand(file, engine)
      component_class_name = File.basename(file, ".rb").classify
      folder_path = File.dirname(file)
      folder_rel_path = Pathname.new( folder_path ).relative_path_from( Pathname.new( root(engine).join('app', 'components') ) ).to_s
      folder_namespace = folder_rel_path.classify
      folder_module = folder_namespace.constantize

      if !folder_module.method_defined?(:new) && component_class_name == folder_namespace.split('::').last
        folder_module.define_singleton_method(:new) do |*args|
          "#{folder_namespace}::#{component_class_name}".constantize.new(*args)
        end
      end
    end
  end
end

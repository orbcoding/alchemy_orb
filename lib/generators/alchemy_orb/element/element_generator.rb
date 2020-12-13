class AlchemyOrb::ElementGenerator < Rails::Generators::NamedBase
  desc "Create Alchemy Element Component."

  class_option :html,
    type: :boolean,
    default: false,
    desc: "Generate separate html.erb file."

  class_option :js,
    type: :boolean,
    default: false,
    desc: "Generate separate js.erb file."

  source_root File.expand_path('templates', __dir__)

  def set_vars
    @element_namespace = "AlchemyElement::#{name.classify}Component"
    @element_class = @element_namespace.split('::').last # MyElement
    @element_name = @element_class.underscore # my_element
    @element_dir_path = "app/alchemy_components/#{@element_namespace.underscore}"
    @element_full_path = "#{@element_dir_path}/#{@element_name}.rb"
  end

  def create_element_file
		# @module_name = options[:module]

		# # generator_path = generator_dir_path + "/#{file_name}_component.rb"

		# FileUtils.mkdir_p(@element_dir_path) unless File.exist?(@element_dir_path)
		# # Dir.mkdir(generator_dir_path) unless File.exist?(generator_dir_path)

    template "element.rb.tt", @element_full_path
		# template "service.erb", generator_path
	end
end

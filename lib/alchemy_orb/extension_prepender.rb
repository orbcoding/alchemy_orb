class AlchemyOrb::ExtensionPrepender < AlchemyOrb::Service

	def initialize(glob:, engine: false)
		@engine = engine
		@glob = glob
		@message = "Prepending#{engine ? ' engine' : ' user'} #{glob.join('/')}"
	end

	def call
		return if @engine == false && !AlchemyOrb::Config.get(:prepend_user_extensions)
		return if @engine == true && !AlchemyOrb::Config.get(:prepend_extensions)

		files = files_except_archive(root.join(*@glob))

		if files.any?
			AlchemyOrb.log(@message)

			skipped_files = []

			files.each do |f|
				require_dependency(f)
				firstline = File.open(f, &:readline)
				unless firstline.include?('skip_prepend: true')
					prepend_extension(f)
				else
					skipped_files.push(File.basename(f))
				end
			end

			AlchemyOrb.log("skipped:\n  " + skipped_files.join("\n  "), newline: true)
		end
	end


	private

	def files_except_archive(glob)
		Dir.glob(glob).reject{|f| f.include?('/_archive/')}
	end

	# Prepends **Extension::Namespace::Of::OriginalExtension
	# to Namespace::Of::Original
	def prepend_extension(file)
		rel_path = root.join(*@glob.join('/').split('/**')[0].split('/'))
		ext_namespace = Pathname(file).relative_path_from(rel_path).to_s.split('.')[0].classify
		original_namespace = ext_namespace.split('Extension::')[1].split('::').join('::').split('Extension').first

		original_namespace.constantize.prepend(ext_namespace.constantize)
	end

	def root
		@engine ? AlchemyOrb::Engine.root : Rails.root
	end
end

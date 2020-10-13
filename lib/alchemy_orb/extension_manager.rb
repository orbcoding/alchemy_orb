module AlchemyOrb::ExtensionManager
	class << self
		def root(engine = false)
			engine ? AlchemyOrb::Engine.root : Rails.root
		end

		def load_extensions(glob:, engine: false)
			return if engine == false && !AlchemyOrb::Config.get(:load_user_extensions)
			return if engine == true && !AlchemyOrb::Config.get(:load_extensions)

			files = files_except_archive(root(engine).join(*glob))

			if files.length
				puts "[AlchemyOrb] Loading#{engine ? ' engine' : ' user'} extensions #{glob.join('/')}"

				files.each do |f|
					require_dependency(f)
					prepend_extension(f, glob, engine)
				end
			end
		end

		def files_except_archive(glob)
			Dir.glob(glob).reject{|f| f.include?('/_archive/')}
		end

		# Prepends **Extension::Namespace::Of::OriginalExtension
		# to Namespace::Of::Original
		def prepend_extension(file, glob, engine)
			rel_path = root(engine).join(*glob.join('/').split('/**')[0].split('/'))
			ext_namespace = Pathname(file).relative_path_from(rel_path).to_s.split('.')[0].classify
			original_namespace = ext_namespace.split('Extension::')[1].split('::').join('::').gsub('Extension', '')

			original_namespace.constantize.prepend(ext_namespace.constantize)
		end
	end
end

module AlchemyOrb::ExtensionPrepender
	extend self

	def call(glob:, engine: false)
		return if engine == false && !AlchemyOrb::Config.get(:prepend_user_extensions)
		return if engine == true && !AlchemyOrb::Config.get(:prepend_extensions)

		files = files_except_archive(root(engine).join(*glob))

		if files.any?
			AlchemyOrb.log("Prepending#{engine ? ' engine' : ' user'} extensions #{glob.join('/')}")

			skipped_files = []

			files.each do |f|
				require_dependency(f)
				firstline = File.open(f, &:readline)
				unless firstline.include?('skip_prepend: true')
					prepend_extension(f, glob, engine)
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
	def prepend_extension(file, glob, engine)
		rel_path = root(engine).join(*glob.join('/').split('/**')[0].split('/'))
		ext_namespace = Pathname(file).relative_path_from(rel_path).to_s.split('.')[0].classify
		original_namespace = ext_namespace.split('Extension::')[1].split('::').join('::').gsub('Extension', '')

		original_namespace.constantize.prepend(ext_namespace.constantize)
	end

	def root(engine = false)
		engine ? AlchemyOrb::Engine.root : Rails.root
	end
end

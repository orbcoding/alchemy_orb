module AlchemyOrb::ModelExtension::Dragonfly::AppExtension
	def get_processor(name)
		if name == :pngquant
			return PngquantProcess.new
		end

		super
	end
end

# Usage
# image.steps.push(Dragonfly::Job::Process.new(image, :pngquant))
class PngquantProcess
	def call(content)
		Piet.pngquant(content.path)
	end
end

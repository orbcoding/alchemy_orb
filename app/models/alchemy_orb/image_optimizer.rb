module AlchemyOrb
	class ImageOptimizer
		OPTIMIZATIONS = [
			'optimize',
			'optimize_large',
			'optimize_keep_format',
			'unoptimize'
		].freeze

# Alchemy dragonfly picture
		def initialize(picture:, format:, optimization:, convertible_format:)

			@opt_img = picture
			@format = format
			@optimization = optimization
			@convertible_format = convertible_format

			@messages = []
			@opt_size = { original: picture.size }
			@opt_time = {}
			@options = [
				"-resize #{Alchemy::Config.get(
					@optimization == 'optimize_large' ?
					:preprocess_image_resize_large : # Added custom large to config
					:preprocess_image_resize
				)}",
				"-strip"
			]
			@jpg_options = "-sampling-factor 4:2:0 -interlace JPEG -colorspace RGB -quality #{Alchemy::Config.get(:output_image_jpg_quality)}"

			prepare_options
		end

		# Set options and messages given optimization and format
		def prepare_options
			if @optimization == 'unoptimize'
				@messages.push("Allowed format #{@format}")
			elsif !(@optimization == 'optimize_keep_format' && @format == 'png')
					@options << @jpg_options
					@convert_to_jpg = true
			end

			@options = @options.join(' ')
		end

		# Main optimization method
		def optimize
			image_magick if @convertible_format && @optimization != 'unoptimize'
			pngquant if @format == 'png' && @optimization == 'optimize_keep_format'
			piet
			set_optimization_messages
			summarize
			return_statement
		end

		# Benchmark method to measure time
		def benchmark
			'%.5f' % Benchmark.realtime {
				yield
			}.round(5)
		end

		# Image magick processing
		def image_magick
			@opt_time[:magick] = benchmark do
				@opt_img = @convert_to_jpg ? @opt_img.encode('jpeg', @options) : @opt_img.convert(@options)
			end

			@opt_size[:magick] = @opt_img.size
		end

		# pngquant compression
		def pngquant
			@opt_time[:pngquant] = benchmark { Piet.pngquant(@opt_img.path) }
			@opt_size[:pngquant] = @opt_img.size
		end

		# Piet png/jpg/gif optimization
		def piet
			@opt_time[:piet] = benchmark do
				png_level = @opt_time.key?(:pngquant) ? 4 : 2 # 7 max can be 1min+ and no gain
				Piet.optimize(@opt_img.path, level: png_level) rescue messages.push('Piet RESCUED OUT')
			end

			@opt_size[:piet] = @opt_img.size
		end

		# Add optimization info to messages
		def set_optimization_messages
			prev_size = @opt_size[:original]
			@opt_time.each{| key, value |
				size_diff = sprintf("%+d", ((@opt_size[key].to_f / prev_size - 1) * 100).round(2))
				@messages.push("#{key.capitalize} time #{value}, size #{size_diff}%")
				prev_size = @opt_size[key]
			}
		end

		# Use optimized image if new image more than 8% smaller than original upload
		def summarize
			size_diff = (@opt_size[:piet].to_f / @opt_size[:original] - 1) * 100
			if size_diff < -8
				@messages.unshift("Optimized#{' and converted' if @convert_to_jpg}, size #{sprintf("%+d", size_diff.round(2))}%. #{@opt_size[:piet].to_f / 1000}kb < #{@opt_size[:original].to_f / 1000}kb")
				@new_image = @opt_img
				@applied_optimizations = @opt_time.keys.join(',')
			else
				@messages.unshift("Image left unchanged, size diff #{sprintf("%+d", size_diff.round(2))}%")
			end
		end

		def return_statement
			{
				new_image: @new_image,
				optimization: @applied_optimizations,
				message: "[AlchemyOrb] #{@messages.join('. ')}.",
			}
		end
	end
end

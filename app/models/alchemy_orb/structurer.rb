# Helpers for arrays, hashes etc
module AlchemyOrb::Structurer
	class << self

		def merge_arrays_of_hashes(arrays:, merge_key:)
			merged_array = arrays.reduce do |merge, next_arr|
				next_arr.each do |h2|
					h1 = merge.detect{|h1| h1[merge_key] == h2[merge_key]}
					if h1
						h1.merge!(h2)
					else
						merge.push(h2)
					end
				end

				merge
			end

			merged_array
		end

	end
end

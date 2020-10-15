module AlchemyOrb
	describe BaseHelper do
		describe '#merge_array_of_hashes' do
			let(:arrays) {[
				[
					{name: '1', value: '1'},
					{name: '2', value: '2'},
					{name: '3', value: '3'},
				],
				[
					{name: '2', value: '2_new'},
					{name: '4', value: '4'}
				],
				[
					{name: '3', value: '3_new'},
					{name: '4', value: '4_new'},
					{name: '5', value: '5'}
				]
			]}

			it 'should merge hashes in correct order' do
				expect(helper.merge_array_of_hashes(arrays: arrays, merge_key: :name))
					.to eq([
						{name: '1', value: '1'},
						{name: '2', value: '2_new'},
						{name: '3', value: '3_new'},
						{name: '4', value: '4_new'},
						{name: '5', value: '5'}
					])
			end
		end
	end
end

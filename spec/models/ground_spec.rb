require 'spec_helper'

describe Ground do
  it { should validate_presence_of(:language) }

  subject { FactoryGirl.build(:ground) }

  it_behaves_like 'a redis model'

  describe('.new_or_default') do
    context 'when language is specified' do
      it 'returns a ground for this language' do
        ground = Ground.new_or_default('test')
        expect(ground.language).to eq('test')
      end
    end

    context 'when language is not specified' do
      it 'returns a ground with default language' do
        ground = Ground.new_or_default(nil)
        expect(ground.language).to eq(Editor.default_option_code(:language))
      end
    end
  end
end

require 'spec_helper'

describe Ground do
  subject(:model) { FactoryGirl.build(:ground) }

  it { should validate_presence_of(:language) }

  it_behaves_like 'a redis model'

  describe('.new_or_default') do
    subject(:model) { Ground.new_or_default(language) }

    context 'when language is specified' do
      let(:language) { 'test' }

      it 'returns a ground for this language' do
        expect(model.language).to eq(language)
      end
    end

    context 'when language is not specified' do
      let(:language) {}

      it 'returns a ground with default language' do
        expect(model.language).to eq(default_language)
      end
    end

    def default_language
      Editor.default_option_code(:language)
    end
  end
end

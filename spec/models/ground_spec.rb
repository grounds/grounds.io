require 'spec_helper'

describe Ground do
  context 'when language is specified' do
    let(:model) { FactoryGirl.build(:ground) }
    
    it_behaves_like 'a valid redis model'
  end

  context 'when language is not specified' do
    let(:model) { FactoryGirl.build(:invalid_ground) }

    it_behaves_like 'an invalid redis model'
  end
end
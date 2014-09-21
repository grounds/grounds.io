require 'spec_helper'
require 'mock_redis'

describe Ground do
  let(:storage) { $redis }
  let(:ground) { FactoryGirl.build(:ground) }

  it 'is convertible to an hash' do
    expected = {'language' => ground.language, 'code' => ground.code}
    expect(ground.serializable_hash).to eq(expected)
  end 
  
  context 'when language is specified' do
    it 'is valid' do
      expect(ground).to be_valid
    end
  end
  
  context 'when language is not specified' do
    let(:invalid_ground) { FactoryGirl.build(:invalid_ground) }

    it 'is valid' do
      expect(invalid_ground).not_to be_valid
    end
    
    it "can't be saved" do
      expect(invalid_ground.save).to be false
    end
    
    it "can't be persisted" do
      invalid_ground.save
      expect(invalid_ground).not_to be_persisted
    end
  end

  context 'when ground is already saved' do
    before(:each) do
      ground.save
    end

    it 'generates a key' do
      expected = '8aa8697c05f23db0083eb2114f83be44e8801929dbf78fb8d25b0f057a423fad'
      expect(ground.id).to eq(expected)
    end
    
    context 'when saved again' do
      it 'has the same id' do
        expected = ground.id
        ground.save
        expect(ground.id).to eq(expected)
      end
    end

    it 'is persisted' do
      expect(ground).to be_persisted
    end

    it 'is exists in storage' do
      expect(storage.exists(ground.id)).to be true
    end

    it 'can be retrieve from storage' do
      expected = Ground.from_storage!(ground.id)
      expect(ground.serializable_hash).to eq(expected.serializable_hash)
    end

    it 'is destroyable' do
      ground.destroy
      expect(ground).not_to be_persisted
    end
  end

  context 'when ground is not saved' do
    it 'has no id' do
      expect(ground.id).to be_nil
    end

    it 'can be saved' do
      expect(ground.save).not_to be_nil
    end

    it "can't be retrieve from storage" do
      expect { Ground.from_storage!(ground.id) }.to raise_error
    end
  end
end

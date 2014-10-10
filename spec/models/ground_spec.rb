require 'spec_helper'
require 'mock_redis'

describe Ground do
  let(:storage) { $redis }
  let(:ground) { FactoryGirl.build(:ground) }

  it 'is convertible to an hash' do
    expected = {'language' => ground.language, 'code' => ground.code}
    expect(ground.attributes).to eq(expected)
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
    
    it "can't be persistent" do
      invalid_ground.save
      expect(invalid_ground).not_to be_persisted
    end
  end

  context 'when already saved' do
    before(:each) do
      ground.save
    end

    context 'when saved again' do
      it 'has the same id' do
        old_id = ground.id
        ground.save
        expect(ground.id).to eq(old_id)
      end
      
      context 'with different attributes' do
        it "hasn't the same id" do
          old_id = ground.id
          ground.code << ';'
          ground.save
          expect(ground.id).not_to eq(old_id)
        end
      end
    end

    it 'is persistent' do
      expect(ground).to be_persisted
    end

    it 'can be found by its id' do
      expected = Ground.find(ground.id)
      expect(ground.attributes).to eq(expected.attributes)
    end

    it 'is destroyable' do
      ground.destroy
      expect(ground).not_to be_persisted
    end
  end

  context 'when not saved' do
    it 'has no id' do
      expect(ground.id).to be_nil
    end

    it 'can be saved' do
      expect(ground.save).not_to be_nil
    end

    it "can't be found" do
      expect { Ground.find(ground.id) }.to raise_error
    end
  end
end

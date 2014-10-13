require 'spec_helper'
require 'mock_redis'

shared_examples_for 'a valid redis model' do
  it 'is valid' do
    expect(model).to be_valid
  end
  
  it 'is convertible to an hash' do
    expect(model.attributes).to be_a(Hash)
  end 
  
  context 'when already saved' do
    before(:each) do
      model.save
    end

    context 'when saved again' do
      it 'has the same id' do
        old_id = model.id
        model.save
        expect(model.id).to eq(old_id)
      end
      
      context 'with different attributes' do
        it "hasn't the same id" do
          old_id = model.id
          attribute = model.attributes.first.first
          value = model.attributes.first.second

          model.send("#{attribute}=", "#{value}0")
          model.save
          expect(model.id).not_to eq(old_id)
        end
      end
    end

    it 'is persistent' do
      expect(model).to be_persisted
    end

    it 'can be found by its id' do
      expected = described_class.find(model.id)
      expect(model.attributes).to eq(expected.attributes)
    end

    it 'is destroyable' do
      model.destroy
      expect(model).not_to be_persisted
    end
  end
  
  context 'when not saved' do
    it 'has no id' do
      expect(model.id).to be_nil
    end

    it 'can be saved' do
      expect(model.save).not_to be_nil
    end

    it "can't be found" do
      expect { described_class.find(model.id) }.to raise_error
    end
  end
end

shared_examples_for 'an invalid redis model' do
  it 'is invalid' do
    expect(model).not_to be_valid
  end

  it "can't be saved" do
    expect(model.save).to be false
  end

  it "can't be persistent" do
    model.save
    expect(model).not_to be_persisted
  end
end
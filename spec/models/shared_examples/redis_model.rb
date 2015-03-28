require 'spec_helper'
require 'mock_redis'

shared_examples_for 'a redis model' do
  before(:each) do
    allow(model).to receive(:valid?).and_return(true)
  end

  it 'is convertible to an hash' do
    expect(model.attributes).to be_a(Hash)
  end

  context 'when already saved' do
    before(:each) do
      model.save
    end

    it 'has an id' do
      expect(model.id).not_to be_nil
    end

    it 'is persistent' do
      expect(model).to be_persisted
    end

    it 'can be retrieved by its id' do
      expected = described_class.find(model.id)
      expect(model).to eq(expected)
    end

    it 'is destroyable' do
      model.destroy
      expect(model).not_to be_persisted
    end

    context 'when saved again' do
      let!(:id) { subject.id }

      it 'has the same id' do
        expect(model.id).to eq(id)
      end

      context 'with different attributes' do
        before(:each) do
          attribute, value = model.attributes.first
          model.send("#{attribute}=", "#{value}0")
          model.save
        end

        it 'has a different id' do
          expect(model.id).not_to eq(id)
        end

        it 'is not equal to previous subject' do
          previous = described_class.find(id)
          expect(model).not_to eq(previous)
        end
      end
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

  context 'when invalid' do
    before(:each) do
      allow(model).to receive(:valid?).and_return(false)
    end

    it "can't be saved" do
      expect(model.save).to be false
    end

    it "can't be persistent" do
      model.save
      expect(model).not_to be_persisted
    end
  end
end

require 'spec_helper'
require 'mock_redis'

shared_examples_for 'a redis model' do
  before(:each) do
    subject.stub(:valid?).and_return(true)
  end
  
  it 'is convertible to an hash' do
    expect(subject.attributes).to be_a(Hash)
  end 
  
  context 'when already saved' do
    before(:each) do
      subject.save
    end

    context 'when saved again' do
      it 'has the same id' do
        old_id = subject.id
        subject.save
        expect(subject.id).to eq(old_id)
      end
      
      context 'with different attributes' do
        it "hasn't the same id" do
          old_id = subject.id
          attribute = subject.attributes.first.first
          value = subject.attributes.first.second

          subject.send("#{attribute}=", "#{value}0")
          subject.save
          expect(subject.id).not_to eq(old_id)
        end
      end
    end

    it 'is persistent' do
      expect(subject).to be_persisted
    end

    it 'can be found by its id' do
      expected = described_class.find(subject.id)
      expect(subject.attributes).to eq(expected.attributes)
    end

    it 'is destroyable' do
      subject.destroy
      expect(subject).not_to be_persisted
    end
  end
  
  context 'when not saved' do
    it 'has no id' do
      expect(subject.id).to be_nil
    end

    it 'can be saved' do
      expect(subject.save).not_to be_nil
    end

    it "can't be found" do
      expect { described_class.find(subject.id) }.to raise_error
    end
  end
  
  context 'when invalid' do
    before(:each) do
      subject.stub(:valid?).and_return(false)
    end
  
    it "can't be saved" do
      expect(subject.save).to be false
    end
  
    it "can't be persistent" do
      subject.save
      expect(subject).not_to be_persisted
    end
  end
end
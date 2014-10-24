require 'spec_helper'

describe GroundsController do
  let(:empty) { '{}' }

  describe '#switch_option' do
    before(:each) do
      switch_option(option, code)
    end
    
    context "when option doesn't exist" do
      let(:option) { 'language' }
      let(:code)   { 'unknown' }
      
      it "doesn't save option in session" do
        expect(session[option]).to be_nil
      end
      
      it 'responds with status :bad_request (400)' do
        respond_with_status(400)
      end
      
      it 'responds with an empty body' do
        expect(response.body).to eq(empty)
      end
    end
 
   # FIXME: dry a bit 
    context "when option type doesn't exist" do
      let(:option) { 'unknown' }
      let(:code)   { 'ruby' }
    
      it "doesn't save option in session" do
        expect(session[option]).to be_nil
      end
      
      it 'responds with status :bad_request (400)' do
        respond_with_status(400)
      end
      
      it 'responds with an empty body' do
        expect(response.body).to eq(empty)
      end
    end
  
    context 'when option exists' do
      let(:option) { 'language' }
      let(:code)   { 'ruby' }

      it 'saves option in session' do
        expect(session[option]).to eq(code)
      end
      
      it 'respond with status :ok (200)' do
        respond_with_status(200)
      end
      
      it 'responds with an empty body' do
        expect(response.body).to eq(empty)
      end
    end
    
    def switch_option(option, code)
      put(:switch_option, option: option, code: code)
    end
  end

  describe '#share' do
    before(:each) do
      share(ground)
    end

    context 'when sharing a valid ground' do
      let(:ground) { FactoryGirl.build(:ground) }

      it 'respond with status :ok (200)' do
        respond_with_status(200)
      end
  
      it 'responds with ground shared url' do
        ground.save
        shared_url = JSON.parse(response.body)['shared_url']

        expect(shared_url).to eq(ground_shared_url(ground))
      end
    end

    context 'when sharing an invalid ground' do
      let(:ground) { FactoryGirl.build(:invalid_ground) }
  
      it 'responds with status :bad_request (400)' do
        respond_with_status(400)
      end
  
      it 'responds with an empty body' do
        expect(response.body).to eq(empty)
      end
    end
    
    def share(ground)
      post(:share, ground: ground.attributes)
    end
  end

  def respond_with_status(code)
    expect(response.status).to eq(code)
  end
end

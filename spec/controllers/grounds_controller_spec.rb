require 'spec_helper'

describe GroundsController do
  context "when option doesn't exist" do
    it "doesn't save option in session" do
      option, code = 'language', 'unknown'
      switch_option(option, code)
      expect(session[option]).to be_nil
    end
  end

  context "when option type doesn't exist" do
    it "doesn't save option in session" do
      option, code = 'unknown', 'ruby'
      switch_option(option, code)
      expect(session[option]).to be_nil
    end
  end

  context 'when option exists' do
    it "saves option in session" do
      option, code = 'language', 'ruby'
      switch_option(option, code)
      expect(session[option]).to eq(code)
    end
  end

  context 'when sharing a valid ground' do
    let(:ground) { FactoryGirl.build(:ground) }

    before(:each) do
      share(ground)
    end

    it 'respond with status :ok (200)' do
      expect(response.status).to eq(200)
    end

    it 'responds with ground shared url' do
      ground.save

      expected = ground_shared_url(ground)
      shared_url = JSON.parse(response.body)['shared_url']
      expect(shared_url).to eq(expected)
    end
  end

  context 'when sharing an invalid ground' do
    before(:each) do
      share(FactoryGirl.build(:invalid_ground))
    end

    it 'responds with status :bad_request (400)' do
      expect(response.status).to eq(400)
    end

    it 'responds with an empty body' do
      expect(response.body).to eq('{}')
    end
  end
  
  def switch_option(option, code)
    put(:switch_option, option: option, code: code)
  end

  def share(ground)
    post(:share, ground: ground.attributes)
  end
end

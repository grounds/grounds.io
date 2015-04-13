require 'spec_helper'

describe GroundsController do
  describe '#switch_option' do
    before do
      put(:switch_option, option: option, code: code)
    end

    context "when option doesn't exist" do
      let(:option) { 'language' }
      let(:code)   { 'unknown' }

      it_behaves_like 'a wrong option switch'
    end

    context "when option type doesn't exist" do
      let(:option) { 'unknown' }
      let(:code)   { 'ruby' }

      it_behaves_like 'a wrong option switch'
    end

    context 'when option exists' do
      let(:option) { 'language' }
      let(:code)   { 'ruby' }

      it 'saves option in session' do
        expect(session[option]).to eq(code)
      end

      it 'respond with status :ok (200)' do
        expect(response.status).to eq(200)
      end

      it 'responds with an empty body' do
        expect(response.body).to be_empty_json
      end
    end
  end

  describe '#share' do
    before do
      post(:share, ground: ground.attributes)
    end

    context 'when sharing a valid ground' do
      let(:ground) { FactoryGirl.build(:ground) }

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
      let(:ground) { FactoryGirl.build(:invalid_ground) }

      it_behaves_like 'a bad json request'
    end
  end
end

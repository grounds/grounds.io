require 'rails_helper'

shared_examples_for 'a bad json request' do
  it 'responds with status :bad_request (400)' do
    expect(response.status).to eq(400)
  end

  it 'responds with an empty body' do
    expect(response.body).to be_empty_json
  end
end

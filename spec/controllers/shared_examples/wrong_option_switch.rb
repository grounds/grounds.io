require 'rails_helper'

shared_examples_for 'a wrong option switch' do
  it "doesn't save option in session" do
    expect(session[option]).to be_nil
  end

  it_behaves_like 'a bad json request'
end

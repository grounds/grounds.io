require 'spec_helper'

shared_examples_for 'a ground without shared url' do
  scenario 'ground has no visible link to a shared url', js: :true do
    expect(ground.shared_url).to be_hidden
  end
end

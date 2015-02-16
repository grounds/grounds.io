require 'spec_helper'

shared_examples_for 'a ground without shared url' do
  scenario 'ground has no visible link to a shared url', js: :true do
    expect(ground.shared_url).to be_hidden
  end
end

shared_examples_for 'a disconnected ground' do
  scenario 'is not connected to runner' do
    expect(ground).not_to be_connected
  end
end

shared_examples_for 'a connected ground' do
  scenario 'ground is connected to runner' do
    expect(ground).to be_connected
  end
end

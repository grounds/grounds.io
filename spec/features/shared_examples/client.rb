require 'spec_helper'

shared_examples_for 'a disconnected client' do
  scenario 'is not connected to runner' do
    expect(client).not_to be_connected
  end
end

shared_examples_for 'a connected client' do
  scenario 'is connected to runner' do
    expect(client).to be_connected
  end
end

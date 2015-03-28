require 'spec_helper'

shared_examples_for 'a page without shared url' do
  scenario 'has no visible link to a shared url', js: :true do
    expect(page.shared_url).to be_hidden
  end
end

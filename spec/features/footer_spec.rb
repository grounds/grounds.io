require 'spec_helper'

feature 'Footer' do
  include HeaderFooterSupport
  
  before(:each) do
    visit(root_path)
  end

  FooterLinks.each do |name, path|
    scenario "has a link to #{name}" do
      click_link(:footer, path)
      expect(current_path).to eq(path)
    end
  end
  
  FooterExternalLinks.each do |name, url|
    scenario "has an external link to #{name}" do
      expect(footer).to have_external_url(url)
    end
  end
end

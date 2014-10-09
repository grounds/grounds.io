require 'spec_helper'

feature 'Sidemenu' do
  include HeaderFooterSupport

  before(:each) do
    visit(root_path)
  end
  
  MenuLinks.each do |name, path|
    scenario "has a link to #{name}" do
      click_link(:sidemenu, path)
      expect(current_path).to eq(path)
    end
  end
  
  MenuExternalLinks.each do |name, url|
    scenario "has an external link to #{name}" do
      expect(header).to have_selector(ext_url_selector(url))
    end
  end
end
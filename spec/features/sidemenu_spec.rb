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
      expect(header).to have_external_url(url)
    end
  end
  
  context 'when opened', js: true do
    before(:each) do
      reduce_screen
      open_sidemenu
    end
    
    scenario 'can be closed' do
      close_sidemenu
      within(:css, selectors[:header_small]) do
        expect(page).to have_sidemenu_open(false)
      end
    end
  end
end
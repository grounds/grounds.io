require 'spec_helper'

feature 'Header' do
  include HeaderFooterSupport

  before(:each) do
    visit(root_path)
  end

  scenario 'has a link to site root' do
    click_link(:header, root_path)
    expect(current_path).to eq(root_path)
  end
  
  MenuLinks.each do |name, path|
    scenario "has a link to #{name}" do
      click_link(:header, path)
      expect(current_path).to eq(path)
    end
  end
  
  MenuExternalLinks.each do |name, url|
    scenario "has an external link to #{name}" do
      expect(header).to have_external_url(url)
    end
  end
  
  context "when user's screen is small", js: true do
    before(:each) do
      reduce_screen
    end

    scenario 'has a link to site root' do
      click_link(:header_small, root_path)
      expect(current_path).to eq(root_path)
    end
    
    scenario 'clicking on the left button open the side menu' do
      click_sidemenu_button
      within(:css, selectors[:header_small]) do
        expect(page).to have_sidemenu_open(true)
      end
    end
  end
end

require 'spec_helper'

feature 'Header' do
  before(:each) do
    visit(root_path)
  end

  scenario 'has a link to site root' do
    has_link_to_site_root
  end
  
  MenuLinks.each do |description, name, href|
    scenario "has a link to #{description}" do
      expect(header).to have_link(name, href: href)
    end
  end
  
  context 'on a small screen', js: true do
    let(:screen) { Screen.new }
    
    before(:each) do
      screen.resize_to_small
    end

    scenario 'has a link to site root' do
      has_link_to_site_root
    end
  end
  
  def has_link_to_site_root
    expect(header).to have_link(I18n.t('site.title'), href: root_path)
  end
  
  def header
    find('header')
  end
end

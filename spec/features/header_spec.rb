require 'spec_helper'

feature 'Header' do
  before(:each) do
    visit(root_path)
  end

  scenario 'has a link to site root' do
    expect(header).to have_link(root_title, href: root_path)
  end

  MENU_LINKS.each do |description, name, href|
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
      expect(header_small).to have_link(root_title, href: root_path)
    end
  end

  def header
    find('.header')
  end

  def header_small
    find('.header-small')
  end

  def root_title
    I18n.t('site.title')
  end
end

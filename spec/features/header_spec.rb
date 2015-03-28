require 'spec_helper'

feature 'Header' do
  subject(:header) { find('.header') }

  let(:root_title) { I18n.t('site.title') }

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
    subject(:header) { find('.header-small') }

    let(:screen) { Screen.new }

    before(:each) do
      screen.resize_to_small
    end

    scenario 'has a link to site root' do
      expect(header).to have_link(root_title, href: root_path)
    end
  end
end

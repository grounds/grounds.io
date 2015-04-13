require 'spec_helper'

feature 'Sidemenu' do
  subject(:sidemenu) { SideMenu.new}

  before do
    visit(root_path)
  end

  MENU_LINKS.each do |description, name, href|
    scenario "has a link to #{description}" do
      expect(sidemenu).to have_link(name, href: href)
    end
  end

  context 'on a small screen', js: true do
    let(:screen) { Screen.new }

    before do
      screen.resize_to_small
    end

    scenario 'can be opened' do
      sidemenu.open

      expect(sidemenu).to be_open
    end

    scenario 'can be closed' do
      subject.close

      expect(sidemenu).not_to be_open
    end
  end
end

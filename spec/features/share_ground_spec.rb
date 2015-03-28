require 'spec_helper'

feature 'Share a ground' do
  subject(:page) { GroundPage.new(ground_show_path) }

  before(:each) do
    page.visit
    page.share
  end

  scenario 'adds to page a shared url to this ground', js: :true do
    expect(page.shared_url).not_to be_empty
  end

  scenario 'adds to page a visible link to this shared ground', js: :true do
    expect(page.shared_url).to be_visible
  end

  scenario 'sets focus to this shared ground url', js: :true do
    expect(page.shared_url).to have_focus
  end

  context 'when selecting another language' do
    before(:each) do
      page.show_options('language')
      page.select_option('language', 'golang')
    end

    it_behaves_like 'a page without shared url'
  end

  context 'when typing inside the code editor' do
    before(:each) do
      page.editor_type_inside
    end

    it_behaves_like 'a page without shared url'
  end
end

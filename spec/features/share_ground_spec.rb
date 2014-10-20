require 'spec_helper'

feature 'Share a ground' do
  let(:ground) { GroundPage.new(ground_show_path) }

  before(:each) do
    ground.visit
    ground.share
  end

  scenario 'adds to page a shared url to this ground', js: :true do
    expect(ground.shared_url).not_to be_empty
  end

  scenario 'adds to page a visible link to this shared ground', js: :true do
    expect(ground.shared_url).to be_visible
  end
  
  scenario 'switches focus on a link to this shared ground', js: :true do
    expect(ground.shared_url).to have_focus
  end

  context 'when selecting another language' do
    scenario 'page has no visible link to this ground shared url', js: :true do
      ground.show_options('language')
      ground.select_option('language', 'golang')

      expect(ground.shared_url).to be_hidden
    end
  end

  context 'when typing inside the code editor' do
    scenario 'page has no visible link to this ground shared url', js: :true do
      ground.editor_type_inside

      expect(ground.shared_url).to be_hidden
    end
  end
end
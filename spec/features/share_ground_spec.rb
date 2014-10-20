require 'spec_helper'

feature 'Share a ground' do
  let(:ground) { GroundPage.new(ground_show_path) }

  before(:each) do
    ground.visit
    ground.share
  end
  
  scenario 'page has a link to this ground shared url', js: :true do
    expect(ground.shared_url).to have_value
  end

  scenario 'page has a visible link to this ground shared url', js: :true do
    expect(ground.shared_url).to be_visible
  end
  
  scenario 'page has focus on this visible link', js: :true do
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
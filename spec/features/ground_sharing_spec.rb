require 'spec_helper'

describe 'ground sharing' do
  include GroundSupport
  
  let(:storage) { $redis }
  let(:ground) { FactoryGirl.build(:ground) }

  context 'after sharing a new ground' do
    before(:each) do
      visit(ground_show_path)
      share
    end

    it 'has a link to this ground shared url', js: :true do
      expect(shared_url).not_to be_empty
    end

    it 'has a visible link to this ground shared url', js: :true do
      expect(shared_url_visible?).to be true
    end
    
    it 'has focus on this visible link', js: :true do
      expect(shared_url_has_focus?).to be true
    end

    context 'when selecting another language' do
      it 'has no visible link to this ground shared url', js: :true do
        show_dropdown('language')
        select_option('language', 'golang')
        expect(shared_url_not_visible?).to be true
      end
    end

    context 'when typing inside the code editor' do
      it 'has no visible link to this ground shared url', js: :true do
        type_inside_editor
        expect(shared_url_not_visible?).to be true
      end
    end
  end

  context 'when visiting a shared ground' do
    before(:each) do
      ground.save
      visit(ground_shared_path(ground))
    end

    it 'has code editor content equal to ground code', js: :true do
      expect(editor_content).to eq(ground.code)
    end

    it 'has selected language label equal to shared ground language label' do
      selected = selected_label('language')
      shared = label('language', ground.language)
      expect(selected).to eq(shared)
    end

    it 'will share the same url', js: :true do
      share
      expect(URI(shared_url).path).to eq(ground_shared_path(ground))
    end
  end

  context 'when visiting a non-existent shared ground' do
    it 'raises an error' do
      expect { visit(ground_shared_path(0)) }.to raise_error
    end
  end
end

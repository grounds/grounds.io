require 'spec_helper'

feature 'Visit a shared ground' do
  let(:shared_ground) { FactoryGirl.build(:ground) }
  let(:ground) { GroundPage.new }

  before(:each) do
    shared_ground.save
    visit(ground_shared_path(shared_ground))
  end

  scenario 'code editor content is equal to shared ground code', js: :true do
    expect(ground.editor).to have_content(shared_ground.code)
  end
  
  scenario 'share will provide the same shared url', js: :true do
    ground.share
    expect(ground.shared_url).to have_path(ground_shared_path(shared_ground))
  end
  
  scenario 'selected language label is equal to shared ground language label' do
    expect(ground).to have_selected_label('language', shared_ground.language)
  end
  
  context "when shared ground doesn't exist" do
    scenario 'an error appears' do
      expect { visit(ground_shared_path(0)) }.to raise_error
    end
  end
end
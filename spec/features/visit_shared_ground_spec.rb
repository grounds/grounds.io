require 'spec_helper'

feature 'Visit a shared ground' do
  subject(:page) { GroundPage.new(path) }

  let(:shared_ground) { FactoryGirl.build(:ground) }
  let(:path) { ground_shared_path(shared_ground) }

  before(:each) do
    shared_ground.save

    page.visit
  end

  it_behaves_like 'a page without shared url'

  scenario 'code editor content is equal to shared ground code', js: :true do
    expect(page.editor).to have_value(shared_ground.code)
  end

  scenario 'share will provide the same shared url', js: :true do
    page.share

    expect(page.shared_url).to have_path(ground_shared_path(shared_ground))
  end

  scenario 'selected language label is equal to shared ground language label' do
    expect(page).to have_selected_label('language', shared_ground.language)
  end

  context 'when shared ground code is empty' do
    let(:shared_ground) { FactoryGirl.build(:empty_ground) }

    scenario 'code editor is empty', js: :true do
      expect(page.editor).to have_value('')
    end
  end

  context "when shared ground doesn't exist" do
    scenario 'an error appears' do
      expect { visit(ground_shared_path(0)) }.to raise_error
    end
  end
end

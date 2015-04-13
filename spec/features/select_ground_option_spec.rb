require 'spec_helper'

feature 'Select a ground option' do
  subject(:page) { GroundPage.new(ground_show_path) }

  let(:custom_session) { CustomSession.new }

  before do
    page.visit
  end

  GROUND_OPTS.each do |option, code|
    context "when selecting #{option}: #{code}" do
      before do
        page.show_options(option)
        page.select_option(option, code)
      end

      scenario "saves selected #{option} in session" do
        expect(custom_session).to have_option(option, code)
      end

      scenario "updates #{option} label", js: :true do
        expect(page).to have_selected_label(option, code)
      end

      scenario "updates code editor #{option}", js: :true do
        expect(page.editor).to have_option(option, code)
      end

      scenario "closes properly #{option} dropdown", js: :true do
        expect(page.dropdown(option)).to be_closed
      end

      scenario 'sets focus to code editor' , js: true do
        expect(page.editor).to be_focused
      end
    end
  end
end

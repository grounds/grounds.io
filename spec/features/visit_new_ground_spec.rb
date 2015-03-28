require 'spec_helper'

feature 'Visit a new ground' do
  subject(:page) { GroundPage.new(ground_show_path) }

  let(:custom_session) { CustomSession.new }

  before(:each) do
    page.visit
  end

  it_behaves_like 'a page without shared url'

  GROUND_OPTS.each do |option, code|
    context "when #{option}: #{code} is not present in session" do
      scenario "initializes #{option} label with default #{option}" do
        expect(page).to have_default_label(option)
      end

      scenario "initializes code editor #{option} with default #{option}", js: :true do
        expect(page.editor).to have_default_option(option)
      end
    end

    context "when #{option}: #{code} is present in session" do
      before(:each) do
        custom_session.set_option(option, code)

        page.visit
      end

      scenario "initializes #{option} label from session" do
        expect(page).to have_selected_label(option, code)
      end

      scenario "initializes code editor #{option} from session", js: :true do
        expect(page.editor).to have_option(option, code)
      end
    end
  end
end

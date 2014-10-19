require 'spec_helper'

feature 'Visit a new ground' do
  let(:options) { TestOptions }
  let(:ground) { GroundPage.new(ground_show_path) }

  before(:each) do
    ground.visit
  end

  scenario 'page has no visible link to a shared url' do
    expect(ground.shared_url).to be_hidden
  end

  scenario 'initializes selected options labels from default option' do
    options.each do |option, _|
      expect(ground).to have_default_label(option)
    end
  end
  
  scenario 'initializes code editor options from default option', js: :true do
    options.each do |option, _|
      expect(ground.editor).to have_default_option(option)
    end
  end
  
  context 'when options has been saved in session' do
    scenario 'initializes selected option label from session' do
      options.each do |option, code|
        ground.set_session(option, code)
        ground.visit

        expect(ground).to have_selected_label(option, code)
      end
    end

    scenario 'initializes code editor option from session', js: :true do
      options.each do |option, code|
        ground.set_session(option, code)
        ground.visit

        expect(ground.editor).to have_option(option, code)
      end
    end
  end
end
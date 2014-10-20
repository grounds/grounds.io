require 'spec_helper'

feature 'Select a ground option' do
  let(:options) { TestOptions }
  let(:ground) { GroundPage.new(ground_show_path) }

  before(:each) do
    ground.visit
  end
  
  scenario 'saves selected option in session' do
    options.each do |option, code|
      ground.visit
      ground.select_option(option, code)

      expect(ground).to have_in_session(option, code)
    end
  end
  
  scenario 'updates option dropdown label', js: :true do
    options.each do |option, code|
      ground.show_options(option)
      ground.select_option(option, code)

      expect(ground).to have_selected_label(option, code)
    end
  end
  
  scenario 'updates code editor option', js: :true do
    options.each do |option, code|
      ground.show_options(option)
      ground.select_option(option, code)

      expect(ground.editor).to have_option(option, code)
    end
  end

  scenario 'closes properly the dropdown associated to this option', js: :true do
    options.each do |option, code|
      ground.show_options(option)
      ground.select_option(option, code)

      expect(ground.dropdown(option)).to be_closed
    end
  end
end
require 'spec_helper'

feature 'Check ground options' do
  subject(:page) { GroundPage.new(ground_show_path) }

  let(:custom_session) { CustomSession.new }

  ALL_GROUND_OPTS.each do |option, code, label|
    context "with #{option}: #{label}" do
      before(:each) do
        custom_session.set_option(option, code)
      end

      scenario "page hasn't any javascript error", js: true do
        expect { page.visit }.not_to raise_error
      end
    end
  end
end

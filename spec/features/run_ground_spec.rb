require 'rails_helper'

feature 'Run a ground', js: true do
  let(:ground) { GroundPage.new(ground_show_path) }

  before(:each) do
    ground.visit
  end

  # Default code example is a ruby program writting "Hello world"
  # on stdout and exiting with a status equal to 0.
  context 'when running default code example' do
    before(:each) do
      ground.run
    end

    scenario 'console displays a waiting message' do
      expect(ground.console).to be_waiting
    end

    scenario 'console displays runner output on stdout' do
      expect(ground.console).to have_on_stdout('Hello world')
    end

    scenario 'console displays a status equal to 0' do
      expect(ground.console).to have_status(0)
    end

    context 'after a run' do
      scenario "console stop displaying a waiting message" do
        expect(ground.console).to have_waited
      end
    end
  end

  # Custom code example is a ruby program writting content
  # on stderr and exiting with a status equal to -1.
  context 'when running custom code example' do
    before(:each) do
      ground.editor_type_inside(custom_code)
      ground.run
    end

    scenario 'console displays runner output on stderr' do
      expect(ground.console).to have_on_stderr(content)
    end

    scenario 'console displays a status equal to -1' do
      expect(ground.console).to have_status(-1)
    end

    def custom_code
      "$stderr.puts \"#{content}\" ; exit -1"
    end

    def content
      '<div>Hello world</div>'
    end
  end

  context 'when runner url is invalid' do
    before(:each) do
      allow(Runner).to receive(:url).and_return(invalid_url)
      ground.visit
    end

    scenario 'console displays a connection error' do
      expect(ground.console).to have_connection_error
    end

    def invalid_url
      'http://127.0.0.1:8081'
    end
  end
end

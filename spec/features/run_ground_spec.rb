require 'spec_helper'

feature 'Run a ground', js: true do
  let(:ground) { GroundPage.new(ground_show_path) }

  before(:each) do
    ground.visit
  end

  it_behaves_like 'a connected ground'

  context 'when running any code example' do
    before(:each) do
      ground.run
    end

    scenario 'console displays a waiting message' do
      expect(ground.console).to be_waiting
    end

    scenario 'run button is disabled' do
      expect(run_button).to be_disabled
    end

    context 'after a run' do
      scenario "console stop displaying a waiting message" do
        expect(ground.console).to have_waited
      end

      scenario 'run button is released' do
        expect(run_button).to be_released
      end
    end

    def run_button
      ground.button(:run)
    end
  end

  # Default code example is a ruby program writting "Hello world"
  # on stdout and exiting with a status equal to 0.
  context 'when running default code example' do
    before(:each) do
      ground.run
    end

    scenario 'console displays runner output on stdout' do
      expect(ground.console).to have_on_stdout('Hello world')
    end

    scenario 'console displays a status equal to 0' do
      expect(ground.console).to have_status(0)
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

    it_behaves_like 'a disconnected ground'

    scenario 'console displays a connection error' do
      expect(ground.console).to have_connection_error
    end

    def invalid_url
      'http://127.0.0.1:8081'
    end
  end

  context 'after leaving a ground' do
    before(:each) do
      visit(page_path('empty'))
    end

    it_behaves_like 'a disconnected ground'
    
    context 'after returning to a ground' do
      before(:each) do
        ground.visit
        
        it_behaves_like 'a connected ground'
      end
    end
  end
end

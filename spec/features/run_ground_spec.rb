require 'spec_helper'

feature 'Run a ground', js: true do
  subject(:page) { GroundPage.new(path) }

  let(:path)   { ground_show_path }
  let(:client) { page }

  before do
    page.visit
  end

  it_behaves_like 'a connected client'

  context 'when running any code example' do
    let(:run_button) { subject.button(:run) }

    before do
      page.run
    end

    scenario 'console displays a waiting message' do
      expect(page.console).to be_waiting
    end

    scenario 'run button is disabled' do
      expect(run_button).to be_disabled
    end

    context 'after a run' do
      scenario "console stop displaying a waiting message" do
        expect(page.console).to have_waited
      end

      scenario 'run button is released' do
        expect(run_button).to be_released
      end
    end
  end

  # Default code example is a ruby program writting "Hello world"
  # on stdout and exiting with a status equal to 0.
  context 'when running default code example' do
    before do
      page.run
    end

    scenario 'console displays runner output on stdout' do
      expect(page.console).to have_on_stdout('Hello world')
    end

    scenario 'console displays a status equal to 0' do
      expect(page.console).to have_status(0)
    end
  end

  # Custom code example is a ruby program writting content
  # on stderr and exiting with a status equal to -1.
  context 'when running custom code example' do
    let(:code)    { "$stderr.puts \"#{content}\" ; exit -1" }
    let(:content) { '<div>Hello world</div>' }

    before do
      page.editor_type_inside(code)
      page.run
    end

    scenario 'console displays runner output on stderr' do
      expect(page.console).to have_on_stderr(content)
    end

    scenario 'console displays a status equal to -1' do
      expect(page.console).to have_status(-1)
    end
  end

  context 'when runner url is invalid' do
    let(:invalid_url) { 'http://127.0.0.1:8081' }

    before do
      allow(Runner).to receive(:url).and_return(invalid_url)

      page.visit
    end

    it_behaves_like 'a disconnected client'

    scenario 'console displays a connection error' do
      expect(page.console).to have_connection_error
    end
  end

  context 'after leaving a ground' do
    let(:path) { page_path('empty') }

    it_behaves_like 'a disconnected client'

    context 'after returning to a ground' do
      let(:path)   { ground_show_path }

      it_behaves_like 'a connected client'
    end
  end
end

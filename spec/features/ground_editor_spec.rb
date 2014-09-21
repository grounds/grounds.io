require 'spec_helper'

describe 'ground editor' do
  include GroundSupport

  let(:options) { TestOptionsTable }

  before(:each) do
    visit(ground_show_path)
  end

  it 'has no visible link to a shared url' do
    expect(shared_url_not_visible?).to be true
  end

  context 'when first visit to a new ground' do
    it 'initializes selected options labels from default option' do
      options.each do |option, _|
        expect(selected_label(option)).to eq(default_label(option))
      end
    end
    
    it 'initializes code editor options from default option', js: :true do
      options.each do |option, _|
        verified = verify_editor_option?(option, default_code(option))
        expect(verified).to be true
      end
    end
  end

  context 'when selecting an option and refreshing ground editor' do
    it 'initializes selected option label from session' do
      options.each do |option, code|
        select_option(option, code)
        refresh
        expect(selected_label(option)).to eq(label(option, code))
      end
    end

    it 'initializes code editor option from session', js: :true do
      options.each do |option, code|
        set_session(option, code)
        refresh
        verified = verify_editor_option?(option, code)
        expect(verified).to be true
      end
    end
  end

  context 'when selecting an option' do
    it 'updates option dropdown label', js: :true do
      options.each do |option, code|
        show_dropdown(option)
        select_option(option, code)
        expect(selected_label(option)).to eq(label(option, code))
      end
    end
    
    it 'update code editor option', js: :true do
      options.each do |option, code|
        show_dropdown(option)
        select_option(option, code)
        verified = verify_editor_option?(option, code)
        expect(verified).to be true
      end
    end

    it 'saves selected option in session' do
      options.each do |option, code|
        refresh
        select_option(option, code)
        expect(session(option)).to eq(code)
      end
    end
    
    it 'closes properly the dropdown associated to this option', js: :true do
      options.each do |option, code|
        show_dropdown(option)
        select_option(option, code)
        expect(dropdown_closed?(option)).to be true
      end
    end
  end
  
  def verify_editor_option?(option, code)
    send("verify_editor_#{option}?", code)
  end
  
  def verify_editor_language?(language)
    editor_mode == mode(language) &&
    editor_content == sample(language) &&
    editor_cursor_on_last_line?
  end
  
  def verify_editor_theme?(theme)
    editor_theme == theme
  end
  
  def verify_editor_indent?(indent)
    use_soft_tabs = indent == 'tab' ? false : true
    tab_size = indent == 'tab' ? 8 : indent.to_i
    editor_use_soft_tabs? == use_soft_tabs &&
    editor_tab_size == tab_size
  end
  
  def verify_editor_keyboard?(keyboard)
    keyboard = keyboard == 'ace' ? '' : keyboard
    editor_keyboard == keyboard
  end
end

module GroundSupport
  EDITOR = 'ground._editor'

  def refresh
    visit(ground_show_path)
  end

  def show_dropdown(option)
    option_dropdown(option).click
  end

  def select_option(option, code)
    find("a[data-#{option}='#{code}']").click
  end
  
  def share
    find('#share').click
  end
  
  def type_inside_editor
    evaluate_script("#{EDITOR}.setValue('typing...');")
  end
  
  def set_session(option, code)
    page.set_rack_session(option => code)
  end
  
  def dropdown_closed?(option)
    option_dropdown(option)['aria-expanded'] == 'false'
  end

  def editor_cursor_on_last_line?
    pos = evaluate_script("#{EDITOR}.getCursorPosition();")
    line = evaluate_script("#{EDITOR}.session.getLength();") - 1;
    pos['row'].to_i == line
  end
  
  def editor_use_soft_tabs?
    evaluate_script("#{EDITOR}.getSession().getUseSoftTabs();")
  end

  def shared_url
    find('input[name="sharedURL"]').value
  end
  
  def shared_url_visible?
    !find('#sharedURL', visible: true).nil?
  end
  
  def shared_url_has_focus?
    # Capybara need to wait that shared url is visible first
    shared_url_visible?

    evaluate_script('document.activeElement.id') == 'sharedURL'
  end
  
  def shared_url_not_visible?
    !find('#sharedURL', visible: false).nil?
  end

  def selected_label(option)
    find("##{option}-name").text
  end
  
  def session(option)
    page.get_rack_session_key(option)
  end

  def option_dropdown(option)
    find("a[data-dropdown='#{option}-dropdown']")
  end

  def editor_content
    evaluate_script("#{EDITOR}.getValue();")
  end

  def editor_mode
    mode = evaluate_script("#{EDITOR}.getSession().getMode().$id;")
    mode.gsub('ace/mode/', '')
  end

  def editor_theme
    theme = evaluate_script("#{EDITOR}.getTheme();")
    theme.gsub('ace/theme/', '')
  end

  def editor_tab_size
    evaluate_script("#{EDITOR}.getSession().getTabSize();")
  end

  def editor_keyboard
     keyboard = evaluate_script("#{EDITOR}.getKeyboardHandler().$id;")
     return '' if keyboard.nil?
     keyboard.gsub('ace/keyboard/', '')
  end

  def mode(language)
    evaluate_script("utils.getMode('#{language}');")
  end

  def sample(language)
    evaluate_script("utils.getSample('#{language}');")
  end
  
  def default_code(option)
    geditor.default_option_code(option)
  end
  
  def default_label(option)
    geditor.default_option_label(option)
  end

  def label(option, code)
    geditor.option(option, code)[:label]
  end
  
  private
  
  def geditor
    GroundEditor
  end
end

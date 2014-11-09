class CodeEditor
  include Capybara::DSL

  def type_inside(text = '')
    evaluate_script("#{js_object}.setValue('#{text}');")
  end
  
  def has_content?(content)
    evaluate_script("#{js_object}.getValue();") == content
  end

  def has_default_option?(option)
    has_option?(option, config.default_code(option))
  end
  
  def has_option?(option, code)
    send("has_#{option}?", code)
  end
  
  def has_language?(code)
    mode == config.mode(code) && 
    has_content?(config.sample(code)) &&
    has_cursor_on_last_line?
  end
  
  def has_theme?(code)
    theme == code
  end
  
  def has_indent?(code)
    if code == 'tab'
      tab_size == 8 && !has_soft_tabs?
    else
      tab_size == code.to_i && has_soft_tabs?
    end
  end
  
  def has_keyboard?(code)
    if code == 'ace'
      keyboard == ''
    else
      keyboard == code
    end
  end
  
  def has_soft_tabs?
    evaluate_script("#{js_object}.getSession().getUseSoftTabs();")
  end
  
  def has_cursor_on_last_line?
    pos = evaluate_script("#{js_object}.getCursorPosition();")
    line = evaluate_script("#{js_object}.session.getLength();") - 1;
    pos['row'].to_i == line
  end
  
  private
  
  def mode
    evaluate_script("#{js_object}.getSession().getMode().$id;").gsub('ace/mode/', '')
  end

  def theme
    evaluate_script("#{js_object}.getTheme();").gsub('ace/theme/', '')
  end

  def tab_size
    evaluate_script("#{js_object}.getSession().getTabSize();")
  end

  def keyboard
     keyboard = evaluate_script("#{js_object}.getKeyboardHandler().$id;")
     # Ace default keyboard has null value
     return '' if keyboard.nil?
     keyboard.gsub('ace/keyboard/', '')
  end
  
  def config
    EditorConfig.new
  end
  
  def js_object
    'ground.editor'
  end
end

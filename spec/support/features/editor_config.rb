class EditorConfig
  include Capybara::DSL

  def label(option, code)
    editor.option_label(option, code)
  end
  
  def default_label(option)
    editor.default_option_label(option)
  end
  
  def default_code(option)
    editor.default_option_code(option)
  end
  
  def mode(language)
    evaluate_script("utils.getMode('#{language}');")
  end

  def sample(language)
    evaluate_script("utils.getSample('#{language}');")
  end
  
  private
  
  def editor
    Editor
  end
end
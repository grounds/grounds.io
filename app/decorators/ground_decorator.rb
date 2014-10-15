class GroundDecorator < BaseDecorator
  def data_attributes
    {
      theme: h.session[:theme] ||= default(:theme),
      indent: h.session[:indent] ||= default(:indent),
      keyboard: h.session[:keyboard] ||= default(:keyboard),
      language: language,
      websocket: WebSocket.url
    }
  end
  
  def options(option)
    editor.options(option)
  end
  
  def selected_label(option)
    editor.option(option, data_attributes[option])[:label]
  end

  private
  
  def default(option)
    editor.default_option_code(option)
  end
  
  def editor
    Editor
  end
end
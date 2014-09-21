class GroundDecorator < BaseDecorator
  def editor
    {
      theme: h.session[:theme] ||= default(:theme),
      indent: h.session[:indent] ||= default(:indent),
      keyboard: h.session[:keyboard] ||= default(:keyboard),
      language: language,
      websocket: WebSocket.url
    }
  end
  
  def options(option)
    geditor.options(option)
  end
  
  def selected_label(option)
    geditor.option(option, editor[option])[:label]
  end

  private
  
  def default(option)
    geditor.default_option_code(option)
  end
  
  def geditor
    GroundEditor
  end
end
class GroundDecorator < BaseDecorator
  delegate :options, to: :editor
  
  def data_attributes
    {
      theme: h.session[:theme] ||= default(:theme),
      indent: h.session[:indent] ||= default(:indent),
      keyboard: h.session[:keyboard] ||= default(:keyboard),
      language: language,
      runner_url: Runner.url
    }
  end
  
  def selected_label(option)
    editor.option_label(option, data_attributes[option])
  end

  private
  
  def default(option)
    editor.default_option_code(option)
  end
  
  def editor
    Editor
  end
end
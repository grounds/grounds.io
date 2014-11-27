class GroundDecorator < BaseDecorator
  def data
    {
      theme: h.session[:theme] ||= default(:theme),
      indent: h.session[:indent] ||= default(:indent),
      keyboard: h.session[:keyboard] ||= default(:keyboard),
      language: language,
      shared: id.present?,
      runner_url: Runner.url
    }
  end

  def shortcuts
    [
      ['⌘ / ctrl', 'enter', I18n.t('editor.run')],
      ['⌘ / ctrl', 's', I18n.t('editor.share')],
      ['⌘ / ctrl', '←', I18n.t('editor.back')],
    ]
  end


  def selected_label(option)
    editor.option_label(option, data[option])
  end

  def options(option)
    editor.options(option).sort
  end

  private

  def default(option)
    editor.default_option_code(option)
  end

  def editor
    Editor
  end
end

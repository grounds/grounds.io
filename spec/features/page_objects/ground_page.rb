class GroundPage < Struct.new(:path)
  include Capybara::DSL

  delegate :type_inside, to: :editor, prefix: true

  def visit
    page.visit(path)
  end

  def share
    find('#share').click
  end

  def shared_url
    SharedUrl.new
  end

  def editor
    CodeEditor.new
  end

  def show_options(option)
    dropdown(option).open
  end

  def select_option(option, code)
    find("a[data-#{option}='#{code}']").click
  end

  def has_selected_label?(option, code)
    selected_label(option) == config.label(option, code)
  end

  def has_default_label?(option)
    selected_label(option) == config.default_label(option)
  end

  def has_in_session?(option, code)
    page.get_rack_session_key(option) == code
  end

  def set_session(option, code)
    # '=>': Option should be saved as a string, not a symbol
    page.set_rack_session(option => code)
  end

  def dropdown(option)
    Dropdown.new(option)
  end

  private

  def selected_label(option)
    find("##{option}-name").text
  end

  def config
    EditorConfig.new
  end
end

class GroundPage < Struct.new(:path)
  include Capybara::DSL

  delegate :type_inside, to: :editor, prefix: true

  def visit
    page.visit(path)
  end

  def leave
    page.visit('/about')
  end

  def run
    button(:run).click
  end

  def share
    button(:share).click
  end

  def shared_url
    SharedUrl.new
  end

  def editor
    CodeEditor.new
  end

  def console
    Console.new
  end

  def dropdown(option)
    Dropdown.new(option)
  end

  def button(id)
    Button.new(id, I18n.t("editor.#{id}"))
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

  def connected?
    evaluate_script('client !== null && client.connected()')
  end

  private

  def selected_label(option)
    find("##{option}-name").text
  end

  def config
    EditorConfig.new
  end
end

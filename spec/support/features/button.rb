class Button < Struct.new(:id, :label)
  include Capybara::DSL

  def click
    click_button(label)
  end

  def disabled?
    page.has_css?(disabled_selector)
  end

  # We need to verify using capybara asynchronous matchers, that
  # button was disabled first, then released.
  def released?
    disabled?
    page.has_no_css?(disabled_selector)
  end

  private

  def selector
    "##{id}"
  end

  def disabled_selector
    "#{selector}[disabled]"
  end
end

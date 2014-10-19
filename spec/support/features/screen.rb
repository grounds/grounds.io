class Screen
  include Capybara::DSL

  def resize_to_small
    page.driver.resize(320, 320)
  end
end
class Dropdown < Struct.new(:id)
  include Capybara::DSL

  def closed?
    element['aria-expanded'] == 'false'
  end

  def open
    element.click
  end

  private

  def element
    find("a[data-dropdown='#{id}']")
  end
end
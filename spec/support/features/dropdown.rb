class Dropdown < Struct.new(:option)
  include Capybara::DSL
  
  def closed?
    object['aria-expanded'] == 'false'
  end
  
  def open
    object.click
  end
  
  private
  
  def object
    find("a[data-dropdown='#{option}-dropdown']")
  end
end
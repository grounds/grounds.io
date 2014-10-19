class SideMenu
  include Capybara::DSL
  
  delegate :have_link, to: :element

  def open
    header.find('a[class="left-off-canvas-toggle menu-icon"]').click
  end
  
  def close
    page.driver.click(300, 300)
  end

  def open?
    header.has_selector?("a[aria-expanded=\"true\"]")
  end
  
  private
  
  def header
    find('.header-small')
  end
  
  def element
    find('.left-off-canvas-menu')
  end
end
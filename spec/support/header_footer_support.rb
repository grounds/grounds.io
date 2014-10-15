module HeaderFooterSupport
  def self.included(base)
    base.class_eval do
      alias_method :click_sidemenu_button, :open_sidemenu
    end
  end
  
  def footer
    find('footer')   
  end
   
  def header
    find('header')
  end

  def have_external_url(url)
    have_selector("a[href=\"#{url}\"][target=\"_blank\"]")
  end
  
  def have_sidemenu_open(value)
    have_selector("a[aria-expanded=\"#{value}\"]")
  end  
  
  def click_link(container, path)
    within(:css, selectors[container]) do
      find("a[href=\"#{path}\"]").click
    end
  end
  
  def open_sidemenu
    within(:css, selectors[:header_small]) do
      find('a[class="left-off-canvas-toggle menu-icon"]').click
    end
  end
  
  def close_sidemenu
    page.driver.click(300, 300)
  end
  
  def reduce_screen
    page.driver.resize(320, 320)
  end

  private
  
  def selectors
    {
      header: '.header',
      header_small: '.header-small',
      sidemenu: '.left-off-canvas-menu',
      footer: 'footer'
    }
  end
end
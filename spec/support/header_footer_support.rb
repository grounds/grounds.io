module HeaderFooterSupport
  def footer
    find('footer')   
  end
   
  def header
    find('header')
  end

  def ext_url_selector(url)
    "a[href=\"#{url}\"][target=\"_blank\"]"
  end
  
  def click_link(container, path)
    within(:css, containers[container]) do
      find("a[href=\"#{path}\"]").click
    end
  end
  
  private
  
  def containers
    {
      header: '.header',
      header_small: '.header-small',
      sidemenu: '.left-off-canvas-menu',
      footer: 'footer'
    }
  end
end
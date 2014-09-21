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
end
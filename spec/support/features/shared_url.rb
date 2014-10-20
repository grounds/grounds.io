class SharedUrl
  include Capybara::DSL

  def empty?
    value.empty?
  end

  def has_focus?
    # It's mandatory to use find with capybara with the exact selector, in
    # javascript mode, find waits for the exact element to appear on the page.
    visible?

    evaluate_script('document.activeElement.id') == 'sharedURL'
  end

  def visible?
    present?(true)
  end

  def hidden?
    present?(false)
  end
  
  def has_path?(path)
    URI(value).path == path
  end

  private
  
  def present?(visible)
    !find('#sharedURL', visible: visible).nil?
  end

  def value
    find('input[name="sharedURL"]').value
  end
end

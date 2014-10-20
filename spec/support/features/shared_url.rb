class SharedUrl
  include Capybara::DSL

  def has_value?
    value.present?
  end

  def has_focus?
    return false if hidden?
    
    evaluate_script('document.activeElement.id') == 'sharedURL'
  end

  # It's mandatory to use find with capybara with the exact selector, in
  # javascript mode, find waits for the exact element to appear on the page.

  def visible?
    !find('#sharedURL', visible: true).nil?
  end

  def hidden?
    !find('#sharedURL', visible: false).nil?
  end
  
  def has_path?(path)
    URI(value).path == path
  end

  private

  def value
    find('input[name="sharedURL"]').value
  end
end

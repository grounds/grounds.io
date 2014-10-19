class SharedUrl
  include Capybara::DSL

  def has_value?
    value.present?
  end

  def has_focus?
    visible?
    
    evaluate_script('document.activeElement.id') == 'sharedURL'
  end

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
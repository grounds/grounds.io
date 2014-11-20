class CustomSession
  include Capybara::DSL

  def has_option?(option, code)
    page.get_rack_session_key(option) == code
  end

  def set_option(option, code)
    # '=>': Option should be saved as a string, not a symbol
    page.set_rack_session(option => code)
  end
end

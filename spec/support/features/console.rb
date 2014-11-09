class Console
  include Capybara::DSL

  def waiting?
    waiting_visible?(true)
  end

  # We need to verify that it's waiting then that waiting message is
  # no longer visible using capybara asynchronous find.
  def has_waited?
    waiting?
    waiting_visible?(false)
  end

  def has_on_stdout?(output)
    has_output?('stdout', output)
  end

  def has_on_stderr?(output)
    has_output?('stderr', output)
  end

  def has_connection_error?
    find('#connect_error')
  end

  def has_status?(status)
    find('.status').text == "[Program exited with status: #{status}]"
  end

  private

  def waiting_visible?(visible)
    find('#waiting', visible: visible)
  end

  def has_output?(stream, chunk)
    find(".#{stream}").text == chunk
  end
end

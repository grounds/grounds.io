class Console
  include Capybara::DSL

  def waiting?
    waiting_visible?(true)
  end

  # We need to verify using capybara asynchronous find, that there is
  # a waiting message on the console output and then that this waiting 
  # message is no longer visible .
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
    find('#connect_error', visible: true)
  end

  def has_status?(status)
    has_output?('status', "[Program exited with status: #{status}]")
  end

  private

  def waiting_visible?(visible)
    find('#waiting', visible: visible)
  end

  def has_output?(stream, chunk)
    output.find(".#{stream}", text: chunk, match: :first)
  end

  def output
    find('.output')
  end
end

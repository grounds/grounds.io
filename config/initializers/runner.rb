module Runner
  extend self

  def url
    ENV['RUNNER_URL']
  end
end

RSpec::Matchers.define :be_empty_json do
  match do |actual|
    actual == '{}'
  end
end

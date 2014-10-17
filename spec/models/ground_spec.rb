require 'spec_helper'

describe Ground do
  it { should validate_presence_of(:language) }

  subject { FactoryGirl.build(:ground) }

  it_behaves_like 'a redis model'
end
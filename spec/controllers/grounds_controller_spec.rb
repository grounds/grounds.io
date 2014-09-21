require 'spec_helper'

describe GroundsController do
  context "when option doesn't exist" do
    it "doesn't save option in session" do
      option, code = 'language', 'unknown'
      switch_option(option, code)
      expect(session[option]).to be_nil
    end
  end

  context "when option type doesn't exist" do
    it "doesn't save option in session" do
      option, code = 'unknown', 'ruby'
      switch_option(option, code)
      expect(session[option]).to be_nil
    end
  end

  context 'when option exists' do
    it "saves option in session" do
      option, code = 'language', 'ruby'
      switch_option(option, code)
      expect(session[option]).to eq(code)
    end
  end
  
  def switch_option(option, code)
    put(:switch_option, option: option, code: code)
  end
end
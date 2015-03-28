require 'spec_helper'

feature 'Footer' do
  subject { find('footer') }

  before(:each) do
    visit(root_path)
  end

  FOOTER_LINKS.each do |description, name, href|
    scenario "has a link to #{description}" do
      expect(subject).to have_link(name, href: href)
    end
  end
end

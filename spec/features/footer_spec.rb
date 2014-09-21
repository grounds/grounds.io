require 'spec_helper'

describe 'footer' do
  include HeaderFooterSupport
  
  before(:each) do
    visit('/')
  end

  it 'has a link to about page' do
    path = '/about'
    click_footer_link(path)
    expect(current_path).to eq(path)
  end

  it 'has a link to contact project developers on github' do
    s = ext_url_selector('https://github.com/grounds/grounds.io/issues/new')
    expect(find('footer')).to have_selector(s)
  end

  it 'has a link to github organization' do
    s = ext_url_selector('https://github.com/grounds')
    expect(footer).to have_selector(s)
  end

  def click_footer_link(path)
    within(:css, 'footer') do
      find("a[href=\"#{path}\"]").click
    end
  end
end

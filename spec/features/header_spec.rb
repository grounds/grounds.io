require 'spec_helper'

describe 'header' do
  include HeaderFooterSupport

  before(:each) do
    visit('/')
  end

  it 'has a link to site root' do
    path = '/'
    click_header_link(path)
    expect(current_path).to eq(path)
  end

  it 'has a link to about page' do
    path = '/about'
    click_header_link(path)
    expect(current_path).to eq(path)
  end
  
  it 'has a link to github organization' do
    s = ext_url_selector('https://github.com/grounds')
    expect(header).to have_selector(s)
  end

  def click_header_link(path)
    within(:css, 'header') do
      find("a[href=\"#{path}\"]").click
    end
  end
end

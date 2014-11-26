module ApplicationHelper
  def title(title)
    content_for(:title, title)
  end

  def gravatar_tag(email, options={})
    id   = Digest::MD5::hexdigest(email).downcase
    size = options[:size] || 128
    image_tag("https://secure.gravatar.com/avatar/#{id}?s=#{size}", options)
  end
end
module ApplicationHelper

  def avatar_image(user, size = 80)
    hash = Digest::MD5.hexdigest(user.email.strip)
    url = "http://www.gravatar.com/avatar/#{hash}"
    url << "?s=#{size}"
    url << "&default=#{CGI::escape('http://placekitten.com/' + size.to_s + '/' + size.to_s)}"
    image_tag(url, :alt => user.name || user.username) 
  end

  def icon_tag(name, size = 32)
    image_tag("icons/#{size}/#{name}.png")
  end

end

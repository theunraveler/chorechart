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

  def format_date(date, options = {})
    defaults = {
      :style => :short
    }
    options = defaults.merge(options)
    case options[:style]
      when :medium
        date.strftime('%A, %B %e')
      else
        date.strftime('%D')
    end
  end

  def fuzzy_date(date)
    days = (date.to_date - Date.today).to_i
    return 'Today' if days >= 0 and days < 1
    return 'Tomorrow' if days >= 1 and days < 2
    return (Date.today + days.days).strftime('%A') if days < 7
    return "In #{days} days" if days < 14
    return format_date(date)
  end

  def in_current_week?(date)
    date.beginning_of_week == Date.today.beginning_of_week
  end

end

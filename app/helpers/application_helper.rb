module ApplicationHelper

  MessageTypes = { :notice => 'success', :warning => 'warning', :error => 'error' }

  def avatar_image(user, size = 80)
    url = "http://www.gravatar.com/avatar/#{user.hashed_email}"
    url << "?s=#{size}"
    url << "&default=#{CGI::escape('http://placekitten.com/' + size.to_s + '/' + size.to_s)}"
    image_tag(url, :alt => user)
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
    days = (date.to_date - Time.current.to_date).to_i
    return 'Today' if days >= 0 and days < 1
    return 'Tomorrow' if days >= 1 and days < 2
    return (Time.current.to_date + days.days).strftime('%A') if days < 7
    return "In #{days} days" if days < 14
    return format_date(date)
  end

  def flash_type(type)
    MessageTypes[type]
  end

  def active_list_link(text, link, *args)
    options = { :class => '' }.merge(args.extract_options!)
    options[:class] << ' active' if current_page?(link)
    link_options = options.has_key?(:link_options) ? options.delete(:link_options) : {}
    content_tag :li, options do
      link_to(text.to_s, link, link_options)
    end
  end

end

ActionView::Base.default_form_builder = TwitterBootstrapFormFor::FormBuilder

module ApplicationHelper

  def avatar_image(user, size = 80)
    hash = Digest::MD5.hexdigest(user.email.strip)
    url = "http://www.gravatar.com/avatar/#{hash}"
    url << "?s=#{size}"
    url << "&default=#{CGI::escape('http://placekitten.com/' + size.to_s + '/' + size.to_s)}"
    image_tag(url, :alt => user.name || user.username)
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

  def flash_type(type)
    types = {
      :notice => 'success',
      :warning => 'warning',
      :error => 'error'
    }
    types[type]
  end

  def active_list_link(text, link)
    options = current_page?(link) ? { :class => 'active' } : {}
    content_tag :li, link_to(text, link), options
  end

end

class ChorechartFormBuilder < ActionView::Helpers::FormBuilder
  # A list of fields we want to decorate
  helpers = field_helpers - %w(hidden_field label fields_for check_box)
  
  helpers.each do |helper|
    define_method helper do |field, *args|
      defaults = { :pass => false }
      options = defaults.merge(args.extract_options!)

      if options[:pass]
        super(field, *args)
      else
        wrapper field do
          @template.render 'shared/form', :label => label(field), :field => super(field, :class => 'xlarge'), :errors => errors_for(field), :options => options
        end
      end
    end
  end

  def check_box_set(*args)
    options = { :label => false }.merge(args.extract_options!)    
    wrapper nil do 
      @template.content_tag :div, :class => 'input' do
        @template.content_tag :ul, :class => 'inputs-list' do
          yield
        end
      end
    end
  end

  def check_box(field, *args)
    options = { :label => true }.merge(args.extract_options!)
    @template.content_tag :li do
      output = super(field, *args)
      output << label(field) if options[:label]
    end
  end

  private

  def wrapper(field, &block)
    @template.content_tag :div, :class => classes_for(field) do
      yield
    end
  end

  def classes_for(field)
    classes = ['clearfix']
    classes << 'error' unless field.nil? || errors_for(field).empty?
    classes
  end

  def errors_for(field)
    @object.errors.on(field) || []
  end

end

ActionView::Base.default_form_builder = ChorechartFormBuilder

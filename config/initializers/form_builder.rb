class ChorechartFormBuilder < ActionView::Helpers::FormBuilder
  # A list of fields we want to decorate
  helpers = field_helpers - %w(hidden_field label fields_for)
  
  helpers.each do |helper|
    define_method helper do |field, *args|
      defaults = { :pass => false }
      options = defaults.merge(args.extract_options!)

      if options[:pass]
        super(field, *args)
      else
        @template.render 'shared/form', :label => label(field), :field => super(field, :class => 'xlarge'), :options => options
      end
    end
  end

  private

  def has_errors?(field_name)
      object.errors.invalid? field_name
  end
end

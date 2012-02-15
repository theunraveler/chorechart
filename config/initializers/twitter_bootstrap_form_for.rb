module TwitterBootstrapFormFor
  class FormBuilder

    # Overridden to include options for toggles wrapper
    #def toggles(label = nil, *args, &block)
      #options = args.extract_options!
      #options[:class] = options.include?(:class) ? options[:class] + ' clearfix' : 'clearfix'
      #template.content_tag(:div, options) do
        #template.concat template.content_tag(:label, label)
        #template.concat template.content_tag(:div, :class => "input") {
          #template.content_tag(:ul, :class => "inputs-list") { block.call }
        #}
      #end
    #end
    
    # Overridden for bootstrap compatibility.
    def toggles(label = nil, *args, &block)
      options = args.extract_options!
      options[:class] = options.include?(:class) ? options[:class] + ' clearfix control-group' : 'clearfix control-group'
      template.content_tag(:div, options) do
        template.concat template.content_tag(:label, label)
        template.concat template.content_tag(:div, :class => "input controls") { block.call }
      end
    end
  
    def actions(&block)
      template.content_tag(:div, :class => 'form-actions', &block)
    end

    INPUTS.each do |input|
      define_method input do |attribute, *args, &block|
        options  = args.extract_options!
        label    = args.first.nil? ? '' : args.shift
        classes  = [ 'input', 'controls' ]
        classes << ('input-' + options.delete(:add_on).to_s) if options[:add_on]

        self.div_wrapper(attribute) do
          template.concat self.label(attribute, label) if label
          template.concat template.content_tag(:div, :class => classes.join(' ')) {
            template.concat super(attribute, *(args << options))
            template.concat error_span(attribute)
            block.call if block.present?
          }
        end
      end
    end

    def submit(value = nil, options = {})
      options[:class] ||= 'btn btn-primary'
      super value, options
    end

    protected

    def div_wrapper(attribute, options = {}, &block)
      options[:id]    = _wrapper_id      attribute, options[:id]
      options[:class] = _wrapper_classes attribute, options[:class], 'clearfix', 'control-group'

      template.content_tag :div, options, &block
    end

  end
end


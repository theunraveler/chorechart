module TwitterBootstrapFormFor
  class FormBuilder

    # Overridden for bootstrap compatibility.
    def toggles(label = nil, *args, &block)
      options = args.extract_options!
      options[:class] = options.include?(:class) ? options[:class] + ' clearfix control-group' : 'clearfix control-group'
      template.content_tag(:div, options) do
        template.concat template.content_tag(:label, label)
        template.concat template.content_tag(:div, :class => "input controls") { block.call }
      end
    end

    def inputs(legend = nil, options = {}, &block)
      template.content_tag(:fieldset, options) do
        template.concat template.content_tag(:legend, legend) unless legend.nil?
        template.concat template.content_tag(:div, :class => "control-group") { block.call }
      end
    end
  
  end
end


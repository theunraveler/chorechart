module TwitterBootstrapFormFor
  class FormBuilder

    # Overridden to include options for toggles wrapper
    def toggles(label = nil, *args, &block)
      options = args.extract_options!
      options[:class] = options.include?(:class) ? options[:class] + ' clearfix' : 'clearfix'
      template.content_tag(:div, options) do
        template.concat template.content_tag(:label, label)
        template.concat template.content_tag(:div, :class => "input") {
          template.content_tag(:ul, :class => "inputs-list") { block.call }
        }
      end
    end

    # Overridden to render plain form builder.
    def inline(label = nil, &block)
      template.content_tag(:div, :class => 'clearfix') do
        template.concat template.content_tag(:label, label) if label.present?
        template.concat template.content_tag(:div, :class => 'input') {
          template.content_tag(:div, :class => 'inline-inputs') do
            template.fields_for(
              self.object_name,
              self.object,
              self.options.merge(:builder => ActionView::Helpers::FormBuilder),
              &block
            )
          end
        }
      end
    end

  end
end

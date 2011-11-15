module PagesHelper

  def image_thumb_tag(path, *args)
    options = args.extract_options!
    options[:rel] = 'lightbox'
    thumb_path = path.gsub('.', '-thumb.')
    link_to image_tag(thumb_path), image_path(path), options
  end

end

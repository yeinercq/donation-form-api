module ApplicationHelper

  # Renders flash messages in flash container
  def render_turbo_stream_flash_messages
    turbo_stream.prepend "flash", partial: "layouts/flash"
  end

  # Adds active class to links
  def link_to_active( text = nil, path = nil, **options, &block )
    link = block_given? ? text : path

    options[:class] = class_names(options[:class], 'active') if current_page? link

    if block_given?
      link_to text, options, &block
    else
      link_to text, path, options
    end
  end

end

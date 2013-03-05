require 'guid'

module ApplicationHelper
  def widget(name, options={}, &block)
    id = Guid.new.to_s
    partial = File.join 'widgets', name.to_s
    attributes = {:id => id, :'data-widget' => name, :style => options.delete(:style), :class => options.delete(:effects)}
    options = {widget_id: id, widget_name: name}.merge options

    html = if block_given?
             render :layout => partial, :inline => capture(&block), :locals => options, :formats => [:html]
           else
             render :template => partial, :locals => options, :formats => [:html]
           end

    javascript = render :template => partial, :locals => options, :formats => [:js] rescue ActionView::MissingTemplate

    content = content_tag :div, html, attributes
    if javascript
      content += content_tag :script, javascript, :type => 'text/javascript'
    end

    content
  end
end

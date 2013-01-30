module ApplicationHelper
  def widget(name, options={}, &block)
    id = Guid.new.to_s
    partial = File.join 'widgets', name.to_s
    attributes = {:id => id, :'data-widget' => name, :style => options.delete(:style), :class => options.delete(:effects)}
    contents = if block_given?
                 render :layout => partial, :inline => capture(&block), :locals => options
               else
                 render :template => partial, :locals => options
               end

    content_tag :div, contents, attributes
  end
end

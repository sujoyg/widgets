module ApplicationHelper
  def widget(name, options={}, &block)
    id = Guid.new.to_s
    partial = File.join 'widgets', name.to_s
    attributes = {:id => id, :'data-widget' => name, :style => options.delete(:style), :class => options.delete(:effects)}
    options[:widget_id] = id unless options.include? :widget_id

    contents = if block_given?
                 render :layout => partial, :inline => capture(&block), :locals => options, :formats => [:html]
               else
                 render :template => partial, :locals => options
               end

    content_tag :div, contents, attributes
  end
end

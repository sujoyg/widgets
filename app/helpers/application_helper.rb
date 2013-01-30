module ApplicationHelper
  def component(name, options={}, &block)
    id = Guid.new.to_s
    partial = File.join 'components', name.to_s
    attributes = {:id => id, :'data-component' => name, :style => options.delete(:style), :class => options.delete(:effects)}
    contents = if block_given?
                 render :layout => partial, :inline => capture(&block), :locals => options
               else
                 render :template => partial, :locals => options
               end

    content_tag :div, contents, attributes
  end
end

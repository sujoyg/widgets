class WidgetsController < ApplicationController
  layout false

  def show
    @name = params.delete(:id)
    @id = params.delete(:widget_id)
    @options = params.except(:controller, :action).to_hash.symbolize_keys!

    respond_to :html, :js
  end
end

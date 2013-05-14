class WidgetsController < ApplicationController
  layout false

  def remove
    @id = params.delete(:id)
    respond_to :js
  end

  def replace
    @id = params.delete(:id)
    @name = params.delete(:name)
    @options = params.except(:controller, :action).to_hash.symbolize_keys!

    respond_to :js
  end

  def show
    @name = params.delete(:id)
    @options = params.except(:controller, :action).to_hash.symbolize_keys!

    respond_to :html, :js
  end
end

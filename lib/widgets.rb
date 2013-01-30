module Widgets
  class Engine < Rails::Engine
    require File.expand_path '../../app/helpers/application_helper', __FILE__
  end
end

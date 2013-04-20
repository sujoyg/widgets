module Widgets
  class Engine < Rails::Engine
    engine_name :widgets

    config.after_initialize do
      require File.expand_path '../../app/controllers/widgets_controller', __FILE__
      require File.expand_path '../../app/helpers/application_helper', __FILE__
    end
  end
end

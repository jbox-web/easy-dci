module EasyDCI
  class Engine < ::Rails::Engine
    isolate_namespace EasyDCI

    ActiveSupport::Inflector.inflections do |inflect|
      inflect.acronym 'DCI'
    end

    config.to_prepare do
      ApplicationController.helper(EasyDCI::Engine.helpers)
    end

  end
end

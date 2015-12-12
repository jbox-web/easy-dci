module EasyDCI
  module ApplicationHelper

    def dci_form_for(object, opts = {}, &block)
      nested = opts.delete(:nested) { false }
      layout = request.xhr? ? :default : :horizontal
      opts   = opts.reverse_merge(remote: request.xhr?, layout: layout)
      if nested
        bootstrap_nested_form_for(object, opts, &block)
      else
        bootstrap_form_for(object, opts, &block)
      end
    end

  end
end

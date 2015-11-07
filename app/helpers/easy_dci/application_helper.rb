module EasyDCI
  module ApplicationHelper

    def dci_form_for(object, opts = {}, &block)
      layout = request.xhr? ? :default : :horizontal
      opts   = opts.reverse_merge(remote: request.xhr?, layout: layout)
      bootstrap_form_for(object, opts, &block)
    end

  end
end

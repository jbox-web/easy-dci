require 'easy_dci/extensions/dci_actions'
require 'easy_dci/extensions/dci_base'
require 'easy_dci/extensions/dci_responses'

module EasyDCI
  module Controller
    extend ActiveSupport::Concern

    included do
      include EasyDCI::Base
      include EasyDCI::Extensions::DCIActions
      include EasyDCI::Extensions::DCIBase
      include EasyDCI::Extensions::DCIResponses
    end

  end
end

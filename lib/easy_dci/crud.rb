require 'easy_dci/base'
require 'easy_dci/crud/builder/model'

require 'easy_dci/crud/extensions/crud_model'
require 'easy_dci/crud/extensions/crud_accessors'
require 'easy_dci/crud/extensions/crud_base'
require 'easy_dci/crud/extensions/crud_breadcrumbs'
require 'easy_dci/crud/extensions/crud_finder'
require 'easy_dci/crud/extensions/dci_actions'
require 'easy_dci/crud/extensions/dci_base'
require 'easy_dci/crud/extensions/dci_responses'
require 'easy_dci/crud/extensions/page_title'

module EasyDCI
  module Crud
    extend ActiveSupport::Concern

    included do
      include EasyDCI::Base
      include EasyDCI::Crud::Extensions::CrudModel
      include EasyDCI::Crud::Extensions::CrudAccessors
      include EasyDCI::Crud::Extensions::CrudBase
      include EasyDCI::Crud::Extensions::CrudBreadcrumbs
      include EasyDCI::Crud::Extensions::CrudFinder
      include EasyDCI::Crud::Extensions::DCIActions
      include EasyDCI::Crud::Extensions::DCIBase
      include EasyDCI::Crud::Extensions::DCIResponses
      include EasyDCI::Crud::Extensions::PageTitle
    end

    class << self

      def default_options
        {
          namespace:     nil,
          parent:        nil,
          crumbable:     false,
          crumbs_opts:   {},
          params: {
            on_create: [],
            on_update: []
          },
          find: {
            only: [:show, :edit, :update, :destroy],
            except: []
          }
        }.clone
      end


      def build_crud_model(model, opts = {})
        Crud::Builder::Model.new(model, opts)
      end

    end

  end
end

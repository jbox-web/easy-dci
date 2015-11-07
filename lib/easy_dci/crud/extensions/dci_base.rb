module EasyDCI
  module Crud
    module Extensions
      module DCIBase
        extend ActiveSupport::Concern

        def create
          set_dci_data(_crud_model.params(:on_create))
          _crud_model.scoped? ? call_dci_context(:create, _crud_scoped_object) : call_dci_context(:create)
        end


        def update
          set_dci_data(_crud_model.params(:on_update))
          call_dci_context(:update, _crud_object)
        end


        def destroy
          call_dci_context(:delete, _crud_object)
        end

      end
    end
  end
end

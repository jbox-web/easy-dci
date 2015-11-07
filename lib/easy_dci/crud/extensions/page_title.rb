module EasyDCI
  module Crud
    module Extensions
      module PageTitle
        extend ActiveSupport::Concern

        private

          def set_page_title
            @page_title = page_title_for(action: action_name)
          end


          def page_title_for(action:)
            method = "page_title_for_#{action}".to_sym
            self.respond_to?(method, true) ? self.send(method) : [t('.title')]
          end


          def page_title_for_index
            [_crud_object_klass.model_name.human(count: 2)]
          end


          def page_title_for_show
            [_crud_object_klass.model_name.human(count: 1), _crud_object.to_s]
          end


          def page_title_for_edit
            [t('.title'), _crud_object.to_s]
          end


          def page_title_for_new
            [t('.title')]
          end


          def page_title_for_create
            page_title_for_new
          end


          def page_title_for_update
            page_title_for_edit
          end

      end
    end
  end
end

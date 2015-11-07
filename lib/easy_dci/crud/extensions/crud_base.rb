module EasyDCI
  module Crud
    module Extensions
      module CrudBase
        extend ActiveSupport::Concern

        included do
          class_attribute :render_flash_messages
          self.render_flash_messages = true
        end


        def index
        end


        def show
        end


        def new
          render_modal_box(locals: locals_for_new)
        end


        def create
        end


        def edit
          render_modal_box(locals: locals_for_edit)
        end


        def update
        end


        def destroy
        end


        private


          def do_render_flash_messages?
            return self.render_flash_messages unless self.render_flash_messages.is_a?(Proc)
            self.render_flash_messages.call(request)
          end


          def locals_for_new
            if _crud_model.scoped?
              { _crud_model_key => _crud_new_scoped_object, _crud_scoped_key => _crud_scoped_object }
            else
              { _crud_model_key => _crud_new_object }
            end
          end


          def locals_for_edit
            if _crud_model.scoped?
              { _crud_model_key => _crud_object, _crud_scoped_key => _crud_scoped_object }
            else
              { _crud_model_key => _crud_object }
            end
          end


          def default_redirect_url
            _crud_model.scoped? ? crud_show_path_for_scoped_object : crud_index_path_for_object
          end

      end
    end
  end
end

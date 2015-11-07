module EasyDCI
  module Crud
    module Extensions
      module DCIActions
        extend ActiveSupport::Concern

        private


          def create_actions
            %w(new create)
          end


          def update_actions
            %w(edit update)
          end


          def create_actions?(action)
            create_actions.include?(action)
          end


          def update_actions?(action)
            update_actions.include?(action)
          end


          def create_action?
            action_name == 'create'
          end


          def update_action?
            action_name == 'update'
          end


          def destroy_action?
            action_name == 'destroy'
          end


          def change_password_action?
            action_name == 'change_password'
          end


          def success_create?(type)
            create_action? && success_action?(type)
          end


          def success_update?(type)
            update_action? && success_action?(type)
          end


          def success_password_update?(type)
            change_password_action? && success_action?(type)
          end

      end
    end
  end
end

module EasyDCI
  module Extensions
    module DCIBase
      extend ActiveSupport::Concern

      included do
        class_attribute :render_flash_messages
        self.render_flash_messages = true
      end


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


      private


        def do_render_flash_messages?
          return self.render_flash_messages unless self.render_flash_messages.is_a?(Proc)
          self.render_flash_messages.call(request)
        end

    end
  end
end

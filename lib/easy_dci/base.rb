module EasyDCI
  module Base
    extend ActiveSupport::Concern

    included do
      class_attribute :dci_context

      class << self
        def set_dci_context(context)
          self.dci_context = context
        end
      end
    end


    private


      def render_success(message: t('.notice'), locals: {}, errors: [], opts: {})
        locals = locals.merge(saved: true)
        render_dci_message(message: message, type: :success, locals: locals, errors: errors, opts: opts)
      end


      def render_failure(message: t('.error'), locals: {}, errors: [], opts: {})
        locals = locals.merge(saved: false)
        render_dci_message(message: message, type: :error, locals: locals, errors: errors, opts: opts)
      end


      def call_dci_context(method, *args, &block)
        render_options = args.extract_options!
        dci_options = get_dci_data
        args << dci_options unless dci_options.nil?

        context = find_or_set_dci_context
        context.send(method, *args, &block)

        if context.success?
          render_success(opts: render_options, **context.locals)
        else
          render_failure(opts: render_options, **context.locals)
        end
      end


      def find_or_set_dci_context
        raise EasyDCI::Error::ContextNotSet if dci_context.nil?

        begin
          dci_context.constantize
        rescue NameError => e
          raise EasyDCI::Error::ContextNotFound, "Class not found: #{dci_context}"
        else
          dci_context.constantize.new(self)
        end
      end


      def set_dci_data(dci_data)
        @dci_data = dci_data
      end


      def get_dci_data
        @dci_data
      end


      def success_action?(type)
        type == :success
      end

  end
end

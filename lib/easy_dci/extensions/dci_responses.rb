module EasyDCI
  module Extensions
    module DCIResponses
      extend ActiveSupport::Concern

      def render_dci_message(message:, type:, locals: {}, errors: [], opts: {})
        set_dci_flash(message, type, errors)
        render_dci_response(template: get_template, type: type, locals: locals, opts: opts)
      end


      private


        def set_dci_flash(message, type, errors = [])
          flash[:notice] = []
          flash[:alert]  = []
          if type == :success
            flash[:notice] << message if do_render_notice_messages?
          else
            flash[:alert] << message if do_render_alert_messages?
          end
          flash[:alert] += errors if do_render_alert_messages? && errors.any?
        end


        def get_dci_data
          return @dci_data if @dci_data.nil?

          rescue_from_error = @dci_data.delete(:rescue) { true }
          strong_params     = @dci_data.delete(:strong_params) { true }

          if strong_params
            if rescue_from_error
              params.require(@dci_data.keys.first).permit(@dci_data.values.first) rescue {}
            else
              params.require(@dci_data.keys.first).permit(@dci_data.values.first)
            end
          else
            @dci_data
          end
        end


        def render_dci_response(template:, type:, locals: {}, opts: {}, &block)
          if block_given?
            yield
          else
            if success_action?(type)
              render_dci_success(template, locals, opts)
            else
              render_dci_failure(template, locals, opts)
            end
          end
        end


        def render_dci_success(template, locals = {}, opts = {})
          dci_response(template, locals, opts.reverse_merge(redirect_url: redirect_url_on_success(locals)))
        end


        def render_dci_failure(template, locals = {}, opts = {})
          dci_response(template, locals, opts.reverse_merge(redirect_url: redirect_url_on_failure(locals), render_partial: true))
        end


        def dci_response(template, locals = {}, opts = {})
          partial      = opts.delete(:render_partial) { false }
          nothing      = opts.delete(:render_nothing) { false }
          layout       = opts.delete(:layout) { current_layout }
          redirect_url = opts.delete(:redirect_url)

          respond_to do |format|
            format.html do
              if partial
                render template, locals: locals, layout: layout
              elsif nothing
                render nothing: true
              else
                redirect_to redirect_url
              end
            end
            format.js do
              if partial
                render ajax_template_path(template), locals: locals
              elsif nothing
                render nothing: true
              else
                render js: "window.location = #{redirect_url.to_json};"
              end
            end
          end
        end


        def redirect_url_on_success(opts = {})
          method = "redirect_url_on_success_#{action_name}"
          self.respond_to?(method, true) ? self.send(method, opts) : default_redirect_url
        end


        def redirect_url_on_failure(opts = {})
          method = "redirect_url_on_failure_#{action_name}"
          self.respond_to?(method, true) ? self.send(method, opts) : default_redirect_url
        end


        def get_template(action: action_name)
          return action if request.xhr?
          return 'new' if create_actions?(action)
          return 'edit' if update_actions?(action)
          return action
        end


        def ajax_template_path(template)
          File.join(get_controller_name, ajax_template_dir, template)
        end


        def ajax_template_dir
          'ajax'
        end


        def get_controller_name
          self.class.name.gsub('Controller', '').underscore
        end


        def current_layout
          'application'
        end

    end
  end
end

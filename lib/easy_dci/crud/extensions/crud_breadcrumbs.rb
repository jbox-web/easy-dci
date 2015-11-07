module EasyDCI
  module Crud
    module Extensions
      module CrudBreadcrumbs
        extend ActiveSupport::Concern

        private

          def add_breadcrumbs_for(action)
            add_breadcrumbs(action: action.to_s)
          end


          def add_breadcrumbs(action: action_name)
            return if !crumbable?

            global_crumb

            case action
            when 'show'
              add_crumb crumb_title_for_scoped_object, crumb_path_for_scoped_object if _crud_model.scoped?
              add_crumb crumb_title_for_object, '#'
            when 'new', 'create'
              add_crumb t('.title'), '#'
            when 'edit', 'update'
              add_crumb crumb_title_for_object, '#'
              add_crumb t('text.edit'), '#'
            else
              ''
            end
          end


          def global_crumb
            add_crumb global_crumb_title, global_crumb_path
          end


          def global_crumb_title
            global_crumb_icon.nil? ? global_crumb_title_without_icon : global_crumb_title_with_icon
          end


          def crumbable?
            _crud_model.crumbable?
          end


          def global_crumb_icon
            _crud_model.crumbs_opts[:icon]
          end


          def global_crumb_title_without_icon
            _crud_model.scoped? ? _crud_scoped_object_klass.model_name.human(count: 2) : _crud_object_klass.model_name.human(count: 2)
          end


          def global_crumb_title_with_icon
            view_context.label_with_icon(global_crumb_title_without_icon, global_crumb_icon, fixed: true, bigger: false)
          end


          def global_crumb_path
            _crud_model.scoped? ? crud_index_path_for_scoped_object : crud_index_path_for_object
          end


          def crumb_title_for_object
            _crud_object.to_s
          end


          def crumb_title_for_scoped_object
            _crud_scoped_object.to_s
          end


          def crumb_path_for_scoped_object
            crud_show_path_for_scoped_object
          end

      end
    end
  end
end

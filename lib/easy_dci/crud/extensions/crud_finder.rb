module EasyDCI
  module Crud
    module Extensions
      module CrudFinder
        extend ActiveSupport::Concern

        included do
          before_action :find_crud_collection, only: :index
          before_action :find_crud_objects
          before_action :set_page_title
          before_action :add_breadcrumbs
        end


        private


          def find_crud_objects
            find_crud_scoped_object if _crud_model.scoped?
            return find_crud_object if _crud_model.find_except_on.any? && _crud_model.find_except_on.include?(action_name.to_sym)
            return find_crud_object if _crud_model.find_only_on.any? && _crud_model.find_only_on.include?(action_name.to_sym)
          end


          def find_crud_object
            object = _crud_model.scoped? ? _crud_scoped_association.find(find_params) : _crud_object_klass.find(find_params)
            instance_variable_set("@#{_crud_model.singular_name}", object)
          rescue ActiveRecord::RecordNotFound => e
            render_404
          end


          def find_crud_scoped_object
            param  = "#{_crud_model.scoped_to.singular_name}_id".to_sym
            object = _crud_scoped_object_klass.find(params[param])
            instance_variable_set("@#{_crud_model.scoped_to.singular_name}", object)
          rescue ActiveRecord::RecordNotFound => e
            render_404
          end


          def find_params
            params[:id]
          end


          def find_crud_collection
            instance_variable_set("@#{_crud_model.plural_name}", _crud_object_klass.all)
          end

      end
    end
  end
end

module EasyDCI
  module Crud
    module Builder
      class Model

        attr_reader :name
        attr_reader :options
        attr_reader :parent
        attr_reader :crumbs_opts


        def initialize(name, opts = {})
          @name        = name
          @options     = EasyDCI::Crud.default_options.deep_merge(opts)
          @parent      = @options.delete(:parent) { nil }
          @crumbable   = @options[:crumbable]
          @crumbs_opts = @options[:crumbs_opts]
        end


        def crumbable?
          @crumbable
        end


        def scoped?
          !scoped_to.nil?
        end


        def scoped_to
          return nil if parent.nil?
          @scoped_to ||= Crud::Builder::Model.new(parent, options)
        end


        def class_name
          "#{name.to_s.camelize.gsub('/', '::')}".gsub('::::', '::')
        end


        def this_class
          class_name.constantize.base_class
        end


        def singular_name
          ActiveModel::Naming.param_key(this_class)
        end


        def plural_name
          singular_name.pluralize
        end


        def namespace
          !options[:namespace].nil? ? "#{options[:namespace]}_" : ''
        end


        def find_only_on
          options[:find][:only]
        end


        def find_except_on
          options[:find][:except]
        end


        def params(type)
          { singular_name.to_sym => options[:params][type] }
        end

      end
    end
  end
end

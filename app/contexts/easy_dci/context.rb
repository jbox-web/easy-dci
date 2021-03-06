module EasyDCI
  class Context

    attr_reader :caller
    attr_reader :locals


    def initialize(caller)
      @caller  = caller
      @locals  = {}
      @success = false
    end


    def success?
      @success == true
    end


    def render_success(**args)
      @success = true
      @locals  = args
    end


    def render_failure(**args)
      @success = false
      @locals  = args
    end


    private


      def call_context(context, method, object, *args)
        klass = "#{context}Context".constantize
        context_obj = klass.new(caller)
        context_obj.send(method, object, *args)
        context_obj
      end


      def t(*args)
        caller.t(*args)
      end

  end
end

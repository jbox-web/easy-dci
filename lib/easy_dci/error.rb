module EasyDCI
  module Error

    class EasyDCIError      < StandardError; end
    class ContextNotFound   < EasyDCIError; end
    class ContextNotSet     < EasyDCIError; end

  end
end

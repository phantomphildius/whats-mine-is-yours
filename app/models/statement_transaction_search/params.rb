module StatementTransactionSearch
  class Params
    def initialize(params)
      @params = params
    end

    def page
      params.fetch(:page, 1)
    end

    private

    attr_reader :params
  end
end

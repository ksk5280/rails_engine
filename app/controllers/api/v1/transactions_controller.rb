module Api
  module V1
    class TransactionsController < MethodsController
      def model
        Transaction
      end
    end
  end
end

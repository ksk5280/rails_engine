module Api
  module V1
    module Transactions
      class InvoiceController < ApiController
        def index
          respond_with Transaction.find(params[:transaction_id]).invoice
        end
      end
    end
  end
end

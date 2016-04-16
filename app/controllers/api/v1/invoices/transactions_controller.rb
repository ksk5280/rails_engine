module Api
  module V1
    module Invoices
      class TransactionsController < ApiController
        def index
          respond_with Invoice.find(params[:invoice_id]).transactions
        end
      end
    end
  end
end

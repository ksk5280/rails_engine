module Api
  module V1
    module Transactions
      class InvoiceController < ApplicationController
        protect_from_forgery with: :null_session
        respond_to :json

        def index
          respond_with Transaction.find(params[:transaction_id]).invoice
        end
      end
    end
  end
end

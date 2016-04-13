module Api
  module V1
    module Customers
      class TransactionsController < ApplicationController
        protect_from_forgery with: :null_session
        respond_to :json

        def index
          respond_with Customer.find(params[:customer_id]).transactions
        end
      end
    end
  end
end

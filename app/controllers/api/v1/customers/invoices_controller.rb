module Api
  module V1
    module Customers
      class InvoicesController < ApiController
        def index
          respond_with Customer.find(params[:customer_id]).invoices
        end
      end
    end
  end
end

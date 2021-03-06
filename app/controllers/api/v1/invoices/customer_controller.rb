module Api
  module V1
    module Invoices
      class CustomerController < ApiController
        def show
          respond_with Invoice.find(params[:invoice_id]).customer
        end
      end
    end
  end
end

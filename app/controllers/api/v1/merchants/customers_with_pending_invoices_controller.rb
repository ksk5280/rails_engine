module Api
  module V1
    module Merchants
      class CustomersWithPendingInvoicesController < ApiController
        def index
          respond_with Merchant.find(params[:merchant_id]).pending_invoices
        end
      end
    end
  end
end

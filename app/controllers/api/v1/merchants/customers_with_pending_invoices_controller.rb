module Api
  module V1
    module Merchants
      class CustomersWithPendingInvoicesController < ApplicationController
        protect_from_forgery with: :null_session
        respond_to :json

        def index
          respond_with Merchant.find(params[:merchant_id]).pending_invoices
        end
      end
    end
  end
end

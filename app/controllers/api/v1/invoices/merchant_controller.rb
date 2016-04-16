module Api
  module V1
    module Invoices
      class MerchantController < ApiController
        def index
          respond_with Invoice.find(params[:invoice_id]).merchant
        end
      end
    end
  end
end

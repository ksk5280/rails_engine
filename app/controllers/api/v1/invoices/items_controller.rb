module Api
  module V1
    module Invoices
      class ItemsController < ApiController
        def index
          respond_with Invoice.find(params[:invoice_id]).items
        end
      end
    end
  end
end

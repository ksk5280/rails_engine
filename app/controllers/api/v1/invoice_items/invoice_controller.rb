module Api
  module V1
    module InvoiceItems
      class InvoiceController < ApiController
        def index
          respond_with InvoiceItem.find(params[:invoice_item_id]).invoice
        end
      end
    end
  end
end

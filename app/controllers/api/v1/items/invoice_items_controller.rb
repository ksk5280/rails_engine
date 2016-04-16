module Api
  module V1
    module Items
      class InvoiceItemsController < ApiController
        def index
          respond_with Item.find(params[:item_id]).invoice_items
        end
      end
    end
  end
end

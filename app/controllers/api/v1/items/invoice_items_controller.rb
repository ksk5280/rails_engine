module Api
  module V1
    module Items
      class InvoiceItemsController < ApplicationController
        protect_from_forgery with: :null_session
        respond_to :json

        def index
          respond_with Item.find(params[:item_id]).invoice_items
        end
      end
    end
  end
end

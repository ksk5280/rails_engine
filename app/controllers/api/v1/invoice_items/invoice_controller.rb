module Api
  module V1
    module InvoiceItems
      class InvoiceController < ApplicationController
        protect_from_forgery with: :null_session
        respond_to :json

        def index
          respond_with InvoiceItem.find(params[:invoice_item_id]).invoice
        end
      end
    end
  end
end

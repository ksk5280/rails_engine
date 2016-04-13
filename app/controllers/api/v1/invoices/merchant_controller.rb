module Api
  module V1
    module Invoices
      class MerchantController < ApplicationController
        protect_from_forgery with: :null_session
        respond_to :json

        def index
          respond_with Invoice.find(params[:invoice_id]).merchant
        end
      end
    end
  end
end

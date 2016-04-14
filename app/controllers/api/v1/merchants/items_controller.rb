module Api
  module V1
    module Merchants
      class ItemsController < ApplicationController
        protect_from_forgery with: :null_session
        respond_to :json

        def index
          respond_with Merchant.find(params[:merchant_id]).items
        end

        def show
          respond_with Merchant.most_items(params[:quantity])
        end
      end
    end
  end
end

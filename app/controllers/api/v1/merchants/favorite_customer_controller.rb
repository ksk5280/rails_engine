module Api
  module V1
    module Merchants
      class FavoriteCustomerController < ApplicationController
        protect_from_forgery with: :null_session
        respond_to :json

        def show
          respond_with Merchant.find(params[:merchant_id]).favorite_customer
        end
      end
    end
  end
end

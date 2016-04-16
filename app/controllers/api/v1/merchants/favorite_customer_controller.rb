module Api
  module V1
    module Merchants
      class FavoriteCustomerController < ApiController
        def show
          respond_with Merchant.find(params[:merchant_id]).favorite_customer
        end
      end
    end
  end
end

module Api
  module V1
    module Customers
      class FavoriteMerchantController < ApplicationController
        protect_from_forgery with: :null_session
        respond_to :json

        def show
          respond_with Customer.find(params[:customer_id]).favorite_merchant
        end
      end
    end
  end
end

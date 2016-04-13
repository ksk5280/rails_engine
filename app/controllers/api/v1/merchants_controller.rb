module Api
  module V1
    class MerchantsController < ApplicationController
      protect_from_forgery with: :null_session
      respond_to :json

      def index
        respond_with Merchant.all
      end

      def show
        respond_with Merchant.find(params[:id])
      end
    end
  end
end

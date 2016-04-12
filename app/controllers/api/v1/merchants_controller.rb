module Api
  module V1
    class MerchantsController < ApiController
      respond_to :json

      def index
        respond_with Merchant.all
      end

      def show
        respond_with Merchant.find(params[:id])
      end

      def find
        attribute = params.first[0].to_sym
        respond_with Merchant.find_by(attribute => params[attribute].downcase)
      end

      def find_all
        attribute = params.first[0].to_sym
        respond_with Merchant.where(attribute => params[attribute].downcase)
      end
    end
  end
end

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
        respond_with Merchant.find_by(attributes(params))
      end

      def find_all
        respond_with Merchant.where(attributes(params))
      end

      def random
        respond_with Merchant.all.sample
      end

      private
        def attributes(params)
          attributes = params.symbolize_keys.except!(:format, :controller, :action)
          attributes.each_value { |v| v.downcase! }
        end
    end
  end
end

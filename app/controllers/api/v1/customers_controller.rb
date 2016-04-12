module Api
  module V1
    class CustomersController < ApiController
      respond_to :json

      def index
        respond_with Customer.all
      end

      def show
        respond_with Customer.find(params[:id])
      end

      def find
        respond_with Customer.find_by(attributes(params))
      end

      def find_all
        respond_with Customer.where(attributes(params))
      end

      def random
        respond_with Customer.all.sample
      end

      private
        def attributes(params)
          attributes = params.symbolize_keys.except!(:format, :controller, :action)
          attributes.each_value { |v| v.downcase! }
        end
    end
  end
end

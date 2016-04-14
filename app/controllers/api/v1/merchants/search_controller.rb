module Api
  module V1
    module Merchants
      class SearchController < ApplicationController
        protect_from_forgery with: :null_session
        respond_to :json

        def index
          respond_with Merchant.where(merchant_params)
        end

        def show
          respond_with Merchant.find_by(merchant_params)
        end

        private
          def merchant_params
            # params.symbolize_keys.except!(:format, :controller, :action)
            # binding.pry
            params.permit(:id, :name, :created_at)
          end
      end
    end
  end
end

module Api
  module V1
    module Merchants
      class MostRevenueController < ApplicationController
        protect_from_forgery with: :null_session
        respond_to :json

        def index
          respond_with Merchant.most_revenue(params[:quantity])
        end
      end
    end
  end
end

module Api
  module V1
    module Merchants
      class RevenueController < ApplicationController
        protect_from_forgery with: :null_session
        respond_to :json
        
        def index
          respond_with Merchant.most_revenue(params[:quantity])
        end

        def show
          if params[:date]
            respond_with Merchant.find(params[:merchant_id]).revenue_by_date(params[:date])
          else
            respond_with Merchant.find(params[:merchant_id]).revenue
          end
        end
      end
    end
  end
end

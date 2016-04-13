module Api
  module V1
    module Items
      class MerchantController < ApplicationController
        protect_from_forgery with: :null_session
        respond_to :json

        def index
          respond_with Item.find(params[:item_id]).merchant
        end
      end
    end
  end
end
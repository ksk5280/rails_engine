module Api
  module V1
    module Items
      class MerchantController < ApiController
        def index
          respond_with Item.find(params[:item_id]).merchant
        end
      end
    end
  end
end

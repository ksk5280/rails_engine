module Api
  module V1
    module Items
      class RandomController < ApplicationController
        protect_from_forgery with: :null_session
        respond_to :json
        
        def show
          respond_with Item.limit(1).order("RANDOM()")
        end
      end
    end
  end
end

module Api
  module V1
    module Items
      class RandomController < ApiController
        def show
          respond_with Item.limit(1).order("RANDOM()")
        end
      end
    end
  end
end

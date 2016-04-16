module Api
  module V1
    module Merchants
      class RandomController < ApiController
        def show
          respond_with Merchant.limit(1).order("RANDOM()")
        end
      end
    end
  end
end

module Api
  module V1
    module Merchants
      class SearchController < ApplicationController
        protect_from_forgery with: :null_session
        respond_to :json

        def index
          respond_with Merchant.where(attributes(params))
        end

        def show
          respond_with Merchant.find_by(attributes(params))
        end

        private
          def attributes(params)
            attributes = params.symbolize_keys.except!(:format, :controller, :action)
          end
      end
    end
  end
end

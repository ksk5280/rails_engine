module Api
  module V1
    class ItemsController < ApplicationController
      protect_from_forgery with: :null_session
      respond_to :json

      def index
        respond_with Item.all
      end

      def show
        binding.pry
        respond_with Item.find(params[:id])
      end
    end
  end
end

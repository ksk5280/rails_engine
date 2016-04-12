module Api
  class ApiController < ApplicationController
    protect_from_forgery with: :null_session
    respond_to :json

    def index
      respond_with model.all
    end

    def show
      respond_with model.find(params[:id])
    end

    def find
      respond_with model.find_by(attributes(params))
    end

    def find_all
      respond_with model.where(attributes(params))
    end

    def random
      respond_with model.limit(1).order("RANDOM()")
    end

    def attributes(params)
      attributes = params.symbolize_keys.except!(:format, :controller, :action)
    end
  end
end

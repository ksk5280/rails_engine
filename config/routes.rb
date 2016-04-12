Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :merchants, except: [:new, :edit] do
        # collection do
          get "find", on: :collection
          get "find_all", on: :collection
        # end
      end
    end
  end
end

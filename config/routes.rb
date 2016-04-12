Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :merchants, except: [:new, :edit] do
          get "find",     on: :collection
          get "find_all", on: :collection
          get "random",   on: :collection
      end
    end
  end
end

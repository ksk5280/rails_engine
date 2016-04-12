Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    namespace :v1 do

      namespace :merchants do
        get "find", to: "search#show"
        get "find_all", to: "search#index"
        get "random", to: "random#show"
      end
      resources :merchants, only: [:index, :show] do
        resources :items, only: [:index], to: "merchants/items#index"
        resources :invoices, only: [:index], to: "merchants/invoices#index"
      end

      resources :customers, only: [:index, :show] do
        collection do
          get "find"
          get "find_all"
          get "random"
        end
      end

      resources :invoices, only: [:index, :show] do
        collection do
          get "find"
          get "find_all"
          get "random"
        end
      end

      resources :invoice_items, only: [:index, :show] do
        collection do
          get "find"
          get "find_all"
          get "random"
        end
      end

      namespace :items, only:[:index, :show] do
        get "find", to: "search#show"
        get "find_all", to: "search#index"
        get "random", to: "random#show"
      end
      resources :items, only: [:index, :show]

      resources :transactions, only: [:index, :show] do
        collection do
          get "find"
          get "find_all"
          get "random"
        end
      end
    end
  end
end

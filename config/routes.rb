Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    namespace :v1 do

      namespace :merchants do
        get "find",         to: "search#show"
        get "find_all",     to: "search#index"
        get "random",       to: "random#show"
        get "most_revenue", to: "revenue#index"
        get "most_items",   to: "items#show"
      end
      resources :merchants, only: [:index, :show], module: "merchants" do
        resources :items, only: [:index],      to: "items#index"
        resources :invoices, only: [:index],   to: "invoices#index"
        get "revenue",                         to: "revenue#show"
        get "customers_with_pending_invoices", to: "customers_with_pending_invoices#index"
        get "favorite_customer",               to: "favorite_customer#show"
      end

      resources :customers, only: [:index, :show], module: "customers" do
        collection do
          get "find"
          get "find_all"
          get "random"
        end
        resources :invoices, only: [:index],     to: "invoices#index"
        resources :transactions, only: [:index], to: "transactions#index"
        get "favorite_merchant",                 to: "favorite_merchant#show"
      end

      resources :invoices, only: [:index, :show], module: "invoices" do
        collection do
          get "find"
          get "find_all"
          get "random"
        end
        get "transactions",  to: "transactions#index"
        get "invoice_items", to: "invoice_items#index"
        get "items",         to: "items#index"
        get "customer",      to: "customer#show"
        get "merchant",      to: "merchant#show"
      end

      resources :invoice_items, only: [:index, :show], module: "invoice_items" do
        collection do
          get "find"
          get "find_all"
          get "random"
        end
        resources :invoice, only: [:index], to: "invoice#index"
        resources :item, only: [:index],    to: "item#index"
      end

      namespace :items, only:[:index, :show] do
        get "find", to: "search#show"
        get "find_all", to: "search#index"
        get "random", to: "random#show"
      end
      resources :items, only: [:index, :show], module: "items" do
        resources :invoice_items, only: [:index], to: "invoice_items#index"
        resources :merchant, only: [:index],      to: "merchant#index"
      end

      resources :transactions, only: [:index, :show], module: "transactions" do
        collection do
          get "find"
          get "find_all"
          get "random"
        end
        resources :invoice, only: [:index], to: "invoice#index"
      end
    end
  end
end

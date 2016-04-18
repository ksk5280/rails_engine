Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :merchants, only: [:index, :show], module: "merchants" do
        collection do
          get "find",         to: "search#show"
          get "find_all",     to: "search#index"
          get "random",       to: "random#show"
          get "most_revenue", to: "revenue#index"
          get "most_items",   to: "items#show"
        end
        get "items",                           to: "items#index"
        get "invoices",                        to: "invoices#index"
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
        get "invoices",          to: "invoices#index"
        get "transactions",      to: "transactions#index"
        get "favorite_merchant", to: "favorite_merchant#show"
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
        get "invoice", to: "invoice#index"
        get "item",    to: "item#index"
      end

      resources :items, only: [:index, :show], module: "items" do
        collection do
          get "find",     to: "search#show"
          get "find_all", to: "search#index"
          get "random",   to: "random#show"
        end
        get "invoice_items", to: "invoice_items#index"
        get "merchant",      to: "merchant#index"
      end

      resources :transactions, only: [:index, :show], module: "transactions" do
        collection do
          get "find"
          get "find_all"
          get "random"
        end
        get "invoice", to: "invoice#index"
      end
    end
  end
end

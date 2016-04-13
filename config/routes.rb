Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    namespace :v1 do

      namespace :merchants do
        get "find",         to: "search#show"
        get "find_all",     to: "search#index"
        get "random",       to: "random#show"
        get "most_revenue", to: "revenue#show"
      end
      resources :merchants, only: [:index, :show] do
        resources :items, only: [:index], to: "merchants/items#index"
        resources :invoices, only: [:index], to: "merchants/invoices#index"
        get "revenue", to: "merchants/revenue#index"
        get "customers_with_pending_invoices", to: "merchants/customers_with_pending_invoices#index"
      end

      resources :customers, only: [:index, :show] do
        collection do
          get "find"
          get "find_all"
          get "random"
        end
        resources :invoices, only: [:index], to: "customers/invoices#index"
        resources :transactions, only: [:index], to: "customers/transactions#index"
      end

      resources :invoices, only: [:index, :show] do
        collection do
          get "find"
          get "find_all"
          get "random"
        end
        resources :transactions, only: [:index], to: "invoices/transactions#index"
        resources :invoice_items, only: [:index], to: "invoices/invoice_items#index"
        resources :items, only: [:index], to: "invoices/items#index"
        resources :customer, only: [:index], to: "invoices/customer#index"
        resources :merchant, only: [:index], to: "invoices/merchant#index"
      end

      resources :invoice_items, only: [:index, :show] do
        collection do
          get "find"
          get "find_all"
          get "random"
        end
        resources :invoice, only: [:index], to: "invoice_items/invoice#index"
        resources :item, only: [:index], to: "invoice_items/item#index"
      end

      namespace :items, only:[:index, :show] do
        get "find", to: "search#show"
        get "find_all", to: "search#index"
        get "random", to: "random#show"
      end
      resources :items, only: [:index, :show] do
        resources :invoice_items, only: [:index], to: "items/invoice_items#index"
        resources :merchant, only: [:index], to: "items/merchant#index"
      end

      resources :transactions, only: [:index, :show] do
        collection do
          get "find"
          get "find_all"
          get "random"
        end
        resources :invoice, only: [:index], to: "transactions/invoice#index"
      end
    end
  end
end

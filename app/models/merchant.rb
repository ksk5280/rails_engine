class Merchant < ActiveRecord::Base
  has_many :items
  has_many :invoices
  has_many :customers, through: :invoices

  # GET /api/v1/merchants/most_revenue?quantity=x returns the top x merchants ranked by total revenue
  # def max_revenue(num)
  # end
end

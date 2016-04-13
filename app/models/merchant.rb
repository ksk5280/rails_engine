class Merchant < ActiveRecord::Base
  has_many :items
  has_many :invoices
  has_many :customers, through: :invoices

  # GET /api/v1/merchants/most_revenue?quantity=x
  # returns to top x merchants ranked by total revenue
  def self.max_revenue(x)
    select("merchants.id, merchants.name, SUM(invoice_items.quantity * invoice_items.unit_price) AS total_revenue").
    joins(:invoices, "INNER JOIN invoice_items on invoices.id=invoice_items.invoice_id").
    group("merchants.id").
    order("total_revenue DESC").
    limit(x)
  end
end

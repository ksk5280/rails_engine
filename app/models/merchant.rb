class Merchant < ActiveRecord::Base
  has_many :items
  has_many :invoices
  has_many :customers, through: :invoices

  # GET /api/v1/merchants/:id/revenue
  # returns the total revenue for that merchant across all transactions
  def revenue
    sum = invoices.
      joins(:invoice_items, :transactions).
      where(transactions: {result: "success"}).
      sum("invoice_items.quantity * invoice_items.unit_price").to_s

    { "revenue" => sum }
  end

  # GET /api/v1/merchants/:id/revenue?date=x
  # returns the total revenue for that merchant for a specific invoice date x
  def revenue_by_date(date)
    realdate = DateTime.parse(date)

    sum = invoices.
      joins(:invoice_items, :transactions).
      where(transactions: {result: "success"}).
      where(invoices: {created_at: realdate.beginning_of_day..realdate.end_of_day }).
      sum("invoice_items.quantity * invoice_items.unit_price").to_s

    { "revenue" => sum }
  end

  # GET /api/v1/merchants/:id/favorite_customer
  # returns the customer who has conducted the most total number of successful transactions
  def favorite_customer
    customers.
      joins(:transactions).
      where(transactions: {result: "success"}).
      group(:id).
      order("transactions.count").last
  end

  # GET /api/v1/merchants/:id/customers_with_pending_invoices
  # returns a collection of customers which have pending (unpaid) invoices
  def pending_invoices
    invoice_ids = invoices.pluck(:id)
    failed_transactions = Transaction.where(invoice_id: invoice_ids).where(result: "failed")
    customer_ids = Invoice.where(id: failed_transactions.pluck(:invoice_id)).pluck(:customer_id)
    Customer.where(id: customer_ids)
  end

  # GET /api/v1/merchants/most_revenue?quantity=x
  # returns to top x merchants ranked by total revenue
  def self.most_revenue(x)
    select("merchants.id, merchants.name, SUM(invoice_items.quantity * invoice_items.unit_price) AS total_revenue").
    joins(invoices: :invoice_items).
    group("merchants.id").
    order("total_revenue DESC").
    limit(x)
  end

  # GET /api/v1/merchants/most_items?quantity=x
  # returns the top x merchants ranked by total number of items sold
  def self.most_items(x)
    select("merchants.id, merchants.name, COUNT(invoice_items.quantity) AS total_items").
    joins(invoices: [:invoice_items, :transactions]).
    where(transactions: {result: "success"}).
    group("merchants.id").
    order("total_items DESC").
    limit(x)
  end

  # GET /api/v1/merchants/revenue?date=x
  # returns the total revenue for date x across all merchants
  def self.revenue_by_date(date)

  end
end

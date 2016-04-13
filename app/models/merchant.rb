class Merchant < ActiveRecord::Base
  has_many :items
  has_many :invoices
  has_many :customers, through: :invoices

  # GET /api/v1/merchants/:id/revenue
  # returns the total revenue for that merchant across all transactions
  def revenue
    # invoice_ids = invoices.pluck(:id)
    # successful_transactions = Transaction.where(invoice_id: invoice_ids).where(result: "success")
    # invoice_ids = Invoice.where(id: successful_transactions.pluck(:invoice_id)).pluck(:id)
    # invoice_items = InvoiceItem.where(invoice_id: invoice_ids)
    # total = invoice_items.each do |invoice_item|
    #   invoice_item.quantity * invoice_item.unit_price
    # end
    # select("SUM(invoice_items.quantity * invoice_items.unit_price) AS total_revenue)").

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
    # joins(:invoices, "INNER JOIN invoice_items on invoices.id=invoice_items.invoice_id").
    group("merchants.id").
    order("total_revenue DESC").
    limit(x)
  end

  # GET /api/v1/merchants/most_items?quantity=x
  # returns the top x merchants ranked by total number of items sold
  # def self.most_items(x)
  #   select("merchants.id, merchants.name, COUNT(invoice_items.quantity) AS total_items").
  #   joins(:invoices, "INNER JOIN invoice_items on invoices.id=invoice_items.invoice_id").
  #   group("merchants.id").
  #   order("total_items DESC").
  #   limit(x)
  # end
end

require 'csv'
require 'bigdecimal'

task :import => [:environment] do
  customers = "db/data/customers.csv"
  invoice_items = "db/data/invoice_items.csv"
  invoices = "db/data/invoices.csv"
  items = "db/data/items.csv"
  merchants = "db/data/merchants.csv"
  transactions = "db/data/transactions.csv"

  CSV.foreach(customers, headers: :true, header_converters: :symbol) do |row|
    Customer.create!(row.to_hash)
  end

  CSV.foreach(transactions, headers: :true, header_converters: :symbol) do |row|
    Transaction.create!(row.to_hash)
  end

  CSV.foreach(merchants, headers: :true, header_converters: :symbol) do |row|
    Merchant.create!(row.to_hash)
  end

  CSV.foreach(invoices, headers: :true, header_converters: :symbol) do |row|
    Invoice.create!(row.to_hash)
  end

  CSV.foreach(items, headers: :true, header_converters: :symbol) do |row|
    Item.create!(id: row[:id], name: row[:name], unit_price: BigDecimal.new(row[:unit_price].insert(-3, ".")), merchant_id: row[:merchant_id], created_at: row[:created_at], updated_at: row[:updated_at])
  end

  CSV.foreach(invoice_items, headers: :true, header_converters: :symbol) do |row|
    InvoiceItem.create!(id: row[:id], item_id: row[:item_id], unit_price: BigDecimal.new(row[:unit_price].insert(-3, ".")), invoice_id: row[:invoice_id], quantity: row[:quantity], created_at: row[:created_at], updated_at: row[:updated_at])
  end
end

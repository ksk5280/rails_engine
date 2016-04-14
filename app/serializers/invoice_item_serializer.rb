class InvoiceItemSerializer < ActiveModel::Serializer
  attributes :id, :item_id, :invoice_id, :quantity, :price, :created_at, :updated_at

  def price
    "$#{object.unit_price}"
  end
end

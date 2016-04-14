class ItemSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :price, :created_at, :updated_at

  def price
    "$#{object.unit_price}"
  end
end

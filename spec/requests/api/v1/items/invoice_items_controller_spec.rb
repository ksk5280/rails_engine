require "rails_helper"

RSpec.describe "GET /api/v1/items/:id/invoice_items" do
  it "returns a collection of associated invoice_items" do
    customer1 = Customer.create(first_name: "Joey", last_name: "Ondricka")
    customer2 = Customer.create(first_name: "Cecilia", last_name: "Osinski")
    merchant1 = Merchant.create(name: "Schroeder-Jerde")
    merchant2 = Merchant.create(name: "Klein, Rempel and Jones")
    item1 = Item.create(
      name: "Shirt",
      description: "Shirt description",
      unit_price: 50,
    )
    item2 = Item.create(
      name: "Pants",
      description: "Pants description",
      unit_price: 75,
    )
    invoice1 = merchant1.invoices.create(
      customer_id: customer1.id,
      status: "shipped",
    )
    invoice2 = merchant2.invoices.create(
      customer_id: customer2.id,
      status: "shipped",
    )
    invoice3 = merchant1.invoices.create(
      customer_id: customer2.id,
      status: "shipped",
    )
    item1.invoice_items.create(
      invoice_id: invoice1.id,
      quantity: 1,
      unit_price: 1000
    )
    item1.invoice_items.create(
      invoice_id: invoice2.id,
      quantity: 2,
      unit_price: 2000
    )
    item2.invoice_items.create(
      invoice_id: invoice3.id,
      quantity: 3,
      unit_price: 3000
    )

    get "/api/v1/items/#{item1.id}/invoice_items"

    expect(response).to be_success
    expect(json_body.count).to eq 2
    expect(json_body.last["quantity"]).to eq 2
    expect(json_body.last["item_id"]).to eq item1.id
  end
end

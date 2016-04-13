require "rails_helper"

RSpec.describe "GET /api/v1/invoice_items/:id/item" do
  it "returns the associated item" do
    customer1 = Customer.create(first_name: "Joey", last_name: "Ondricka")
    customer2 = Customer.create(first_name: "Cecilia", last_name: "Osinski")
    merchant1 = Merchant.create(name: "Schroeder-Jerde")
    merchant2 = Merchant.create(name: "Klein, Rempel and Jones")
    item1 = merchant1.items.create(
      name: "Shirt",
      description: "Shirt description",
      unit_price: 50,
      )
    item2 = merchant2.items.create(
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
    status: "not shipped",
      )
    invoice_item1 = invoice1.invoice_items.create(
      item_id: item1.id,
      quantity: 1,
      unit_price: 1111.0,
    )
    invoice_item2 = invoice2.invoice_items.create(
      item_id: item2.id,
      quantity: 2,
      unit_price: 2222.0,
    )

    get "/api/v1/invoice_items/#{invoice_item1.id}/item"

    expect(response).to be_success
    expect(json_body["name"]).to eq "Shirt"
    expect(json_body["id"]).to eq invoice_item1.id
  end
end

require "rails_helper"

RSpec.describe "GET /api/v1/invoices/:id/invoice_items" do
  it "returns a collection of associated invoice_items" do
    customer1 = Customer.create(first_name: "Joey", last_name: "Ondricka")
    customer2 = Customer.create(first_name: "Cecilia", last_name: "Osinski")
    merchant1 = Merchant.create(name: "Schroeder-Jerde")
    merchant2 = Merchant.create(name: "Klein, Rempel and Jones")
    item1 = merchant1.items.create(
      name: "Shirt",
      description: "Shirt description",
      unit_price: 50,
      )
    item2 = merchant1.items.create(
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
    invoice1.invoice_items.create(
      item_id: item1.id,
      quantity: 1,
      unit_price: 1111.0,
    )
    invoice1.invoice_items.create(
      item_id: item1.id,
      quantity: 2,
      unit_price: 2222.0,
    )
    invoice2.invoice_items.create(
      item_id: item2.id,
      quantity: 3,
      unit_price: 3333.0,
    )

    get "/api/v1/invoices/#{invoice1.id}/invoice_items"

    expect(response).to be_success
    expect(json_body.count).to eq 2
    expect(json_body.last["quantity"]).to eq 2
  end
end

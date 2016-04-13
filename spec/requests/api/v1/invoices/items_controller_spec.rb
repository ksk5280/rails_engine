require "rails_helper"

RSpec.describe "GET /api/v1/invoices/:id/items" do
  it "returns a collection of associated items" do
    customer1 = Customer.create(first_name: "Joey", last_name: "Ondricka")
    customer2 = Customer.create(first_name: "Cecilia", last_name: "Osinski")
    merchant1 = Merchant.create(name: "Schroeder-Jerde")
    merchant2 = Merchant.create(name: "Klein, Rempel and Jones")
    invoice1 = merchant1.invoices.create(
      customer_id: customer1.id,
      status: "shipped",
      )
    invoice2 = merchant2.invoices.create(
    customer_id: customer2.id,
    status: "shipped",
      )
    invoice1.items.create(
      name: "Shirt",
      description: "Shirt description",
      unit_price: 50,
    )
    invoice1.items.create(
      name: "Pants",
      description: "Pants description",
      unit_price: 75,
    )
    invoice2.items.create(
      name: "Socks",
      description: "Socks description",
      unit_price: 75,
    )

    get "/api/v1/invoices/#{invoice1.id}/items"

    expect(response).to be_success
    expect(json_body.count).to eq 2
    expect(json_body.last["name"]).to eq "Pants"
  end
end

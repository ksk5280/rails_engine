require "rails_helper"

RSpec.describe "GET /api/v1/merchants/:id/invoices" do
  it "returns a collection of invoices associated with that merchant" do
    merchant1 = Merchant.create(name: "Schroeder-Jerde")
    merchant2 = Merchant.create(name: "Klein, Rempel and Jones")
    customer1 = Customer.create(first_name: "Joey", last_name: "Ondricka")
    customer2 = Customer.create(first_name: "Cecilia", last_name: "Osinski")
    merchant1.invoices.create(
      customer_id: customer1.id,
      status: "shipped",
      )
    merchant1.invoices.create(
    customer_id: customer2.id,
    status: "shipped",
      )
    merchant2.invoices.create(
      customer_id: customer1.id,
      status: "shipped",
      )

    get "/api/v1/merchants/#{merchant1.id}/invoices"

    expect(response).to be_success
    expect(json_body.count).to eq(2)
    expect(json_body.last["customer_id"]).to eq customer2.id
  end
end

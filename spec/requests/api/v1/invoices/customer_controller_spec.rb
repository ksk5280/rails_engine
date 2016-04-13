require "rails_helper"

RSpec.describe "GET /api/v1/customers/:id/invoices" do
  it "returns a collection of associated invoices" do
    customer1 = Customer.create(first_name: "Joey", last_name: "Ondricka")
    customer2 = Customer.create(first_name: "Cecilia", last_name: "Osinski")
    merchant1 = Merchant.create(name: "Schroeder-Jerde")
    merchant2 = Merchant.create(name: "Klein, Rempel and Jones")
    invoice1 = customer1.invoices.create(
      merchant_id: merchant1.id,
      status: "shipped",
    )
    invoice2 = customer1.invoices.create(
      merchant_id: merchant2.id,
      status: "not shipped",
    )
    invoice3 = customer2.invoices.create(
    merchant_id: merchant2.id,
    status: "shipped",
    )

    get "/api/v1/customers/#{customer1.id}/invoices"

    expect(response).to be_success
    expect(json_body.count).to eq 2
    expect(json_body.last["status"]).to eq "not shipped"
  end
end

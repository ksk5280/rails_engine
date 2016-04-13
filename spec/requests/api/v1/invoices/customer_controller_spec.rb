require "rails_helper"

RSpec.describe "GET /api/v1/invoices/:id/customer" do
  it "returns the associated customer" do
    customer1 = Customer.create(first_name: "Joey", last_name: "Ondricka")
    customer2 = Customer.create(first_name: "Cecilia", last_name: "Osinski")
    merchant1 = Merchant.create(name: "Schroeder-Jerde")
    merchant2 = Merchant.create(name: "Klein, Rempel and Jones")
    invoice1 = customer1.invoices.create(
      merchant_id: merchant1.id,
      status: "shipped",
      )
    invoice2 = customer2.invoices.create(
    merchant_id: merchant2.id,
    status: "shipped",
      )

    get "/api/v1/invoices/#{invoice1.id}/customer"

    expect(response).to be_success
    expect(json_body["first_name"]).to eq "Joey"
  end
end

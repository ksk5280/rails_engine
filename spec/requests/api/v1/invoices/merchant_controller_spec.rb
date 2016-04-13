require "rails_helper"

RSpec.describe "GET /api/v1/invoices/:id/merchant" do
  it "returns the associated merchant" do
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

    get "/api/v1/invoices/#{invoice1.id}/merchant"

    expect(response).to be_success
    expect(json_body["name"]).to eq "Schroeder-Jerde"
  end
end

require "rails_helper"

RSpec.describe "GET /api/v1/transactions/:id/invoice" do
  it "returns the associated invoice" do
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
      status: "not shipped",
    )
    transaction1 = invoice1.transactions.create(
      result: "success",
      credit_card_number: "1111111111111111",
    )
    transaction2 = invoice1.transactions.create(
      result: "success",
      credit_card_number: "2222222222222222",
    )

    get "/api/v1/transactions/#{transaction1.id}/invoice"

    expect(response).to be_success
    expect(json_body["id"]).to eq invoice1.id
    expect(json_body["status"]).to eq "shipped"
  end
end

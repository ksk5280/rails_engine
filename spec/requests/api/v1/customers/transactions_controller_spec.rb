require "rails_helper"

RSpec.describe "GET /api/v1/customers/:id/transactions" do
  it "returns a collection of associated transactions" do
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
    invoice1.transactions.create(
      result: "success",
      credit_card_number: "1111111111111111",
    )
    invoice1.transactions.create(
      result: "success",
      credit_card_number: "2222222222222222",
    )
    invoice2.transactions.create(
      result: "success",
      credit_card_number: "3333333333333333",
    )

    get "/api/v1/customers/#{invoice1.id}/transactions"

    expect(response).to be_success
    expect(json_body.count).to eq 2
    expect(json_body.last["credit_card_number"]).to eq "2222222222222222"
  end
end

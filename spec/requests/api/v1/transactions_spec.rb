require "rails_helper"
require "test_helper"

RSpec.describe "GET /api/v1/transactions" do
  it "returns a list of transactions" do
    create_transactions

    get "/api/v1/transactions"

    expect(response).to be_success
    expect(json_body.count).to eq(3)
  end
end


RSpec.describe "GET /api/v1/transactions/1" do
  it "returns a single Transaction" do
    create_transactions

    get "/api/v1/transactions/#{@trans1.id}"

    expect(response).to be_success
    expect(json_body["result"]).to eq "failed"
    expect(json_body["credit_card_number"]).to eq "1111111111111111"
  end
end

RSpec.describe "GET /api/v1/transactions/find?credit_card_number=1111111111111111" do
  it "returns transaction with credit_card_number = 1111111111111111" do
    create_transactions

    get "/api/v1/transactions/find?credit_card_number=1111111111111111"

    expect(response).to be_success
    expect(json_body["result"]).to eq "failed"
    expect(json_body["credit_card_number"]).to eq "1111111111111111"
  end
end

def create_transactions
  cust1 = create_customer("Joey", "Ondricka")
  cust2 = create_customer("Cecilia", "Osinski")
  cust3 = create_customer("Mariah", "Toy")
  merc1 = create_merchant("Schroeder-Jerde")
  merc2 = create_merchant("Klein, Rempel and Jones")
  inv1  = create_invoice(cust1.id, merc1.id, "shipped")
  inv2  = create_invoice(cust2.id, merc2.id, "shipped")
  @trans1 = create_transaction("failed", inv1.id, "1111111111111111")
  trans2 = create_transaction("success", inv1.id, "2222222222222222")
  trans3 = create_transaction("success", inv2.id, "3333333333333333")
end

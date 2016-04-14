require "rails_helper"

RSpec.describe "GET /api/v1/customers/:id/transactions" do
  it "returns a collection of associated transactions" do
    item1 = create_item("Shirt", "Shirt description", 50)
    item2 = create_item("Pants", "Pants description", 75)
    item3 = create_item("Socks", "Socks description", 100)
    cust1 = create_customer("Joey", "Ondricka")
    cust2 = create_customer("Cecilia", "Osinski")
    cust3 = create_customer("Mariah", "Toy")
    merc1 = create_merchant("Schroeder-Jerde")
    merc2 = create_merchant("Klein, Rempel and Jones")
    inv1  = create_invoice(cust1.id, merc1.id, "pending")
    inv2  = create_invoice(cust2.id, merc2.id, "shipped")
    inv3  = create_invoice(cust3.id, merc2.id, "shipped")
    invitem1 = create_invoice_item(item1.id, inv1.id, 1, 100)
    invitem2 = create_invoice_item(item2.id, inv2.id, 2, 200)
    invitem3 = create_invoice_item(item3.id, inv3.id, 3, 100)
    trans1 = create_transaction("success", inv1.id, "1111111111111111")
    trans2 = create_transaction("success", inv1.id, "2222222222222222")
    trans3 = create_transaction("success", inv2.id, "3333333333333333")

    get "/api/v1/customers/#{cust1.id}/transactions"

    expect(response).to be_success
    expect(json_body.count).to eq 2
    expect(json_body.last["credit_card_number"]).to eq "2222222222222222"
  end
end

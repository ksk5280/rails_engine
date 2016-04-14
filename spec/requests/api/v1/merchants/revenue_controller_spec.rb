require "rails_helper"

RSpec.describe "GET /api/v1/merchants/:id/revenue" do
  it "returns total revenue for that merchant across all transactions" do
    merc1 = create_merchant("Schroeder-Jerde")
    merc2 = create_merchant("Klein, Rempel and Jones")
    item1 = create_item("Shirt", "Shirt description", 50)
    item2 = create_item("Pants", "Pants description", 75)
    item3 = create_item("Socks", "Socks description", 100)
    cust1 = create_customer("Joey", "Ondricka")
    cust2 = create_customer("Cecilia", "Osinski")
    cust3 = create_customer("Mariah", "Toy")
    inv1  = create_invoice(cust1.id, merc1.id, "pending")
    inv2  = create_invoice(cust2.id, merc1.id, "shipped")
    inv3  = create_invoice(cust3.id, merc2.id, "shipped")
    invitem1 = create_invoice_item(item1.id, inv1.id, 1, 100)
    invitem2 = create_invoice_item(item2.id, inv2.id, 2, 200)
    invitem3 = create_invoice_item(item3.id, inv3.id, 3, 100)
    create_transaction("success", inv1.id, "1111111111111111")
    create_transaction("success", inv1.id, "1111111111111111")
    create_transaction("success", inv2.id, "1111111111111111")
    create_transaction("success", inv2.id, "2222222222222222")
    create_transaction("failed",  inv2.id, "2222222222222222")
    create_transaction("success", inv3.id, "3333333333333333")

    get "/api/v1/merchants/#{merc1.id}/revenue"

    expect(response).to be_success
    expect(json_body["revenue"]).to eq "1000.0"
  end
end

require "rails_helper"
require "test_helper"

RSpec.describe "GET /api/v1/invoice_items" do
  it "returns a list of invoice_items" do
    create_invoice_items

    get "/api/v1/invoice_items"

    expect(response).to be_success
    expect(json_body.count).to eq(3)
  end
end


RSpec.describe "GET /api/v1/invoice_items/1" do
  it "returns a single invoice" do
    create_invoice_items

    get "/api/v1/invoice_items/#{@invitem1.id}"

    expect(response).to be_success
    expect(json_body["quantity"]).to eq 1
  end
end

RSpec.describe "GET /api/v1/invoice_items/find?quantity=1" do
  it "returns invoice with status = 1" do
    create_invoice_items

    get "/api/v1/invoice_items/find?quantity=1"

    expect(response).to be_success
    expect(json_body["quantity"]).to eq 1
  end
end

def create_invoice_items
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
  @invitem1 = create_invoice_item(item1.id, inv1.id, 1, 100)
  invitem2 = create_invoice_item(item2.id, inv2.id, 2, 200)
  invitem3 = create_invoice_item(item3.id, inv3.id, 3, 100)
end

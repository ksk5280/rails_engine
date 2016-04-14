require "rails_helper"

RSpec.describe "GET /api/v1/merchants" do
  it "returns a list of merchants" do
    Merchant.create(name: "Schroeder-Jerde")
    Merchant.create(name: "Klein, Rempel and Jones")

    get "/api/v1/merchants"

    expect(response).to be_success
    expect(json_body.count).to eq(2)
  end
end

RSpec.describe "GET /api/v1/merchants/1" do
  it "returns a single merchant" do
    merchant = Merchant.create(name: "Schroeder-Jerde")

    get "/api/v1/merchants/#{merchant.id}"

    expect(response).to be_success
    expect(json_body["name"]).to eq "Schroeder-Jerde"
  end
end

RSpec.describe "GET /api/v1/merchants/find?name=Schroeder-Jerde" do
  it "returns merchant with name = Schroeder-Jerde" do
    Merchant.create(name: "Schroeder-Jerde")

    get "/api/v1/merchants/find?name=Schroeder-Jerde"

    expect(response).to be_success
    expect(json_body["name"]).to eq "Schroeder-Jerde"
  end
end

RSpec.describe "GET /api/v1/merchants/find?name=schroeder-jerde" do
  it "returns merchant with name = Schroeder-Jerde, case-insensitive" do
    Merchant.create(name: "Schroeder-Jerde")

    get "/api/v1/merchants/find?name=schroeder-jerde"

    expect(response).to be_success
    expect(json_body["name"]).to eq "Schroeder-Jerde"
  end
end

RSpec.describe "GET /api/v1/merchants/find?name=klein, rempel and jones" do
  it "returns merchant with name = klein, rempel and jones" do
    Merchant.create(name: "Klein, Rempel and Jones")

    get "/api/v1/merchants/find?name=Klein%2C%20Rempel%20and%20Jones"

    expect(response).to be_success
    expect(json_body["name"]).to eq "Klein, Rempel and Jones"
  end
end

RSpec.describe "GET /api/v1/merchants/find_all?name=Cummings-Thiel" do
  it "returns all merchants whose name matches Cummings-Thiel" do
    Merchant.create(name: "Cummings-Thiel")
    Merchant.create(name: "Cummings-Thiel")
    Merchant.create(name: "Schroeder-Jerde")

    get "/api/v1/merchants/find_all?name=Cummings-Thiel"

    expect(response).to be_success
    expect(json_body.count).to eq 2
  end
end

RSpec.describe "GET api/v1/merchants/random" do
  it "returns a random merchant" do
    Merchant.create(name: "Schroeder-Jerde")
    Merchant.create(name: "Klein, Rempel and Jones")
    Merchant.create(name: "Willms and Sons")

    get "/api/v1/merchants/random"

    expect(response).to be_success
    expect(Merchant.find(json_body[0]["id"]).valid?).to be true
  end
end

RSpec.describe "GET /api/v1/merchants/most_revenue?quantity=x" do
  it "returns the top x merchants ranked by total revenue" do
    create_all

    get "/api/v1/merchants/most_revenue?quantity=2"

    expect(response).to be_success
    expect(json_body.count).to eq 2
  end
end

RSpec.describe "GET /api/v1/merchants/:id/favorite_customer" do
  it "returns the favorite customer for the merchant" do
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
    trans1 = create_transaction("failed", inv1.id, "1111111111111111")
    trans2 = create_transaction("success", inv1.id, "2222222222222222")
    trans3 = create_transaction("success", inv2.id, "3333333333333333")

    get "/api/v1/merchants/#{merc1.id}/favorite_customer"

    expect(response).to be_success
    expect(json_body["first_name"]).to eq "Joey"
    expect(json_body["last_name"]).to eq "Ondricka"
  end
end


RSpec.describe "GET /api/v1/merchants/:id/customers_with_pending_invoices" do
  it "returns the pending invoices for the merchant" do
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
    trans1 = create_transaction("failed", inv1.id, "1111111111111111")
    trans2 = create_transaction("success", inv1.id, "2222222222222222")
    trans3 = create_transaction("success", inv2.id, "3333333333333333")

    get "/api/v1/merchants/#{merc1.id}/customers_with_pending_invoices"

    expect(response).to be_success
    expect(json_body[0]["first_name"]).to eq "Joey"
    expect(json_body[0]["last_name"]).to eq "Ondricka"
  end
end

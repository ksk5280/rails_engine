require "rails_helper"
require "test_helper"

RSpec.describe "GET /api/v1/customers" do
  it "returns a list of customers" do
    create_customer("Joey", "Ondricka")
    create_customer("Cecilia", "Osinski")
    create_customer("Mariah", "Toy")

    get "/api/v1/customers"

    expect(response).to be_success
    expect(json_body.count).to eq(3)
  end
end

RSpec.describe "GET /api/v1/customers/1" do
  it "returns a single customer" do
    customer = Customer.create(first_name: "Joey", last_name: "Ondricka")

    get "/api/v1/customers/#{customer.id}"

    expect(response).to be_success
    expect(json_body["first_name"]).to eq "Joey"
    expect(json_body["last_name"]).to eq "Ondricka"
  end
end

RSpec.describe "GET /api/v1/customers/find?first_name=Joey" do
  it "returns customer with first_name = Joey" do
    Customer.create(first_name: "Joey", last_name: "Ondricka")

    get "/api/v1/customers/find?first_name=Joey"

    expect(response).to be_success
    expect(json_body["first_name"]).to eq "Joey"
    expect(json_body["last_name"]).to eq "Ondricka"
  end
end

RSpec.describe "GET /api/v1/customers/find?first_name=joey" do
  it "returns customer with first_name = joey, case-insensitive" do
    Customer.create(first_name: "Joey", last_name: "Ondricka")

    get "/api/v1/customers/find?first_name=joey"

    expect(response).to be_success
    expect(json_body["first_name"]).to eq "Joey"
    expect(json_body["last_name"]).to eq "Ondricka"
  end
end

RSpec.describe "GET /api/v1/customers/find?last_name=Ondricka" do
  it "returns customer with last_name = Ondricka" do
    Customer.create(first_name: "Joey", last_name: "Ondricka")

    get "/api/v1/customers/find?last_name=Ondricka"

    expect(response).to be_success
    expect(json_body["first_name"]).to eq "Joey"
    expect(json_body["last_name"]).to eq "Ondricka"
  end
end

RSpec.describe "GET /api/v1/customers/find_all?first_name=Cecilia" do
  it "returns all customers whose first name matches Cecilia" do
    Customer.create(first_name: "Joey", last_name: "Ondricka")
    Customer.create(first_name: "Cecilia", last_name: "Osinski")
    Customer.create(first_name: "Cecilia", last_name: "Smith")

    get "/api/v1/customers/find_all?first_name=Cecilia"

    expect(response).to be_success
    expect(json_body.count).to eq 2
  end
end

RSpec.describe "GET api/v1/customers/random" do
  it "returns a random customer" do
    Customer.create(first_name: "Joey", last_name: "Ondricka")
    Customer.create(first_name: "Cecilia", last_name: "Osinski")
    Customer.create(first_name: "Mariah", last_name: "Toy")

    get "/api/v1/customers/random"

    expect(response).to be_success
    expect(Customer.find(json_body[0]["id"]).valid?).to be true
  end
end

RSpec.describe "GET /api/v1/customers/:id/favorite_merchant" do
  it "returns the favorite merchant for the customer" do
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

    get "/api/v1/customers/#{cust1.id}/favorite_merchant"

    expect(response).to be_success
    expect(json_body["name"]).to eq "Schroeder-Jerde"
  end
end

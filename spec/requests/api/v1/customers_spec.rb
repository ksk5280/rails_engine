require "rails_helper"

RSpec.describe "GET /api/v1/customers" do
  it "returns a list of customers" do
    Customer.create(first_name: "Joey", last_name: "Ondricka")
    Customer.create(first_name: "Cecilia", last_name: "Osinski")
    Customer.create(first_name: "Mariah", last_name: "Toy")

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
    expect(json_body["first_name"]).to eq "joey"
    expect(json_body["last_name"]).to eq "ondricka"
  end
end

RSpec.describe "GET /api/v1/customers/find?first_name=joey" do
  it "returns customer with first_name = joey" do
    Customer.create(first_name: "Joey", last_name: "Ondricka")

    get "/api/v1/customers/find?first_name=joey"

    expect(response).to be_success
    expect(json_body["first_name"]).to eq "joey"
    expect(json_body["last_name"]).to eq "ondricka"
  end
end

RSpec.describe "GET /api/v1/customers/find?last_name=ondricka" do
  it "returns customer with last_name = ondricka" do
    Customer.create(first_name: "Joey", last_name: "Ondricka")

    get "/api/v1/customers/find?last_name=ondricka"

    expect(response).to be_success
    expect(json_body["first_name"]).to eq "joey"
    expect(json_body["last_name"]).to eq "ondricka"
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
    expect(Customer.find(json_body["id"]).valid?).to be true
  end
end

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
    expect(json_body["name"]).to eq "schroeder-jerde"
  end
end

RSpec.describe "GET /api/v1/merchants/find?name=Schroeder-Jerde" do
  it "returns merchant with name = Schroeder-Jerde" do
    Merchant.create(name: "Schroeder-Jerde")

    get "/api/v1/merchants/find?name=Schroeder-Jerde"

    expect(response).to be_success
    expect(json_body["name"]).to eq "schroeder-jerde"
  end
end

RSpec.describe "GET /api/v1/merchants/find?name=klein, rempel and jones" do
  it "returns merchant with name = klein, rempel and jones" do
    Merchant.create(name: "Klein, Rempel and Jones")

    get "/api/v1/merchants/find?name=Klein%2C%20Rempel%20and%20Jones"

    expect(response).to be_success
    expect(json_body["name"]).to eq "klein, rempel and jones"
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
    Merchant.create(name: "schroeder-jerde")
    Merchant.create(name: "klein, rempel and jones")
    Merchant.create(name: "willms and sons")

    get "/api/v1/merchants/random"

    expect(response).to be_success
    expect(Merchant.find(json_body["id"]).valid?).to be true
  end
end

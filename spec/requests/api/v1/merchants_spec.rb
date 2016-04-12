require "rails_helper"

RSpec.describe "GET /api/v1/merchants" do
  it "returns a list of merchants" do
    merchant1 = Merchant.create(name: "Schroeder-Jerde")
    merchant2 = Merchant.create(name: "Klein, Rempel and Jones")

    get "/api/v1/merchants"
    json_body = JSON.parse(response.body)

    expect(response).to be_success

    expect(json_body.count).to eq(2)
  end
end

RSpec.describe "GET /api/v1/merchants/1" do
  it "returns a single merchant" do
    merchant = Merchant.create(name: "Schroeder-Jerde")

    get "/api/v1/merchants/#{merchant.id}"
    json_body = JSON.parse(response.body)

    expect(response).to be_success
    expect(json_body["name"]).to eq "Schroeder-Jerde"
  end
end

RSpec.describe "GET /api/v1/merchants/find?name=Schroeder-Jerde" do
  it "returns merchant with name = Schroeder-Jerde" do
    merchant = Merchant.create(name: "Schroeder-Jerde")

    get "/api/v1/merchants/find?name=Schroeder-Jerde"
    json_body = JSON.parse(response.body)

    expect(response).to be_success
  end
end

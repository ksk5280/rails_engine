require "rails_helper"

RSpec.describe "GET /api/v1/merchants" do
  it "returns a list of merchants" do
    merchant1 = Merchant.create(name: "Schroeder-Jerde")
    merchant2 = Merchant.create(name: "Klein, Rempel and Jones")

    get '/api/v1/merchants'
    json_body = JSON.parse(response.body)

    expect(response).to be_success

    expect(json_body.count).to eq(2)
  end
end

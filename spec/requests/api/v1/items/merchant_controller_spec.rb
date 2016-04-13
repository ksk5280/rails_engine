require "rails_helper"

RSpec.describe "GET /api/v1/items/:id/merchant" do
  it "returns the associated merchant" do
    merchant1 = Merchant.create(name: "Schroeder-Jerde")
    merchant2 = Merchant.create(name: "Klein, Rempel and Jones")
    item1 = merchant1.items.create(
      name: "Shirt",
      description: "Shirt description",
      unit_price: 50,
      )
    item2 = merchant2.items.create(
      name: "Pants",
      description: "Pants description",
      unit_price: 75,
      )

    get "/api/v1/items/#{item1.id}/merchant"

    expect(response).to be_success
    expect(json_body["name"]).to eq "Schroeder-Jerde"
    expect(json_body["id"]).to eq merchant1.id
  end
end

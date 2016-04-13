require "rails_helper"

RSpec.describe "GET /api/v1/merchants/:id/items" do
  it "returns a collection of items associated with that merchant" do
    merchant1 = Merchant.create(name: "Schroeder-Jerde")
    merchant2 = Merchant.create(name: "Klein, Rempel and Jones")
    merchant1.items.create(
      name: "Shirt",
      description: "Shirt description",
      unit_price: 50,
      )
    merchant1.items.create(
      name: "Pants",
      description: "Pants description",
      unit_price: 75,
      )
    merchant2.items.create(
      name: "Socks",
      description: "Socks description",
      unit_price: 75,
      )

    get "/api/v1/merchants/#{merchant1.id}/items"

    expect(response).to be_success
    expect(json_body.count).to eq 2
    expect(json_body.last["name"]).to eq "Pants"
  end
end

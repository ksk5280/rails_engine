require "rails_helper"

RSpec.describe "GET /api/v1/merchants/:id/items" do
  it "returns a collection of items associated with that merchant" do
    merchant = Merchant.create(name: "Schroeder-Jerde")
    merchant.items.create(
      name: "Shirt",
      description: "Shirt description",
      unit_price: 5000,
      )
    merchant.items.create(
      name: "Pants",
      description: "Pants description",
      unit_price: 7500,
      )

    get "/api/v1/merchants/1/items"

    expect(response).to be_success
    expect(json_body.count).to eq(2)
  end
end

require "rails_helper"

def create_items
  Item.create(
    name: "Shirt",
    description: "Shirt description",
    unit_price: 50,
  )
  Item.create(
    name: "Pants",
    description: "Pants description",
    unit_price: 75,
  )
  Item.create(
    name: "Socks",
    description: "Socks description",
    unit_price: 25,
  )
end

RSpec.describe "GET /api/v1/items" do
  it "returns a list of items" do
    create_items

    get "/api/v1/items"

    expect(response).to be_success
    expect(json_body.count).to eq(3)
  end
end

RSpec.describe "GET /api/v1/items/1" do
  it "returns a single item" do
    item = Item.create(
      name: "Shirt",
      description: "Shirt description",
      unit_price: 50,
    )

    get "/api/v1/items/#{item.id}"

    expect(response).to be_success
    expect(json_body["name"]).to eq "Shirt"
  end
end

RSpec.describe "GET /api/v1/items/find?name=Shirt" do
  it "returns item with name = Shirt" do
    create_items

    get "/api/v1/items/find?name=Shirt"

    expect(response).to be_success
    expect(json_body["name"]).to eq "Shirt"
  end
end

RSpec.describe "GET /api/v1/items/find?name=shirt" do
  it "returns item with name = Shirt, case-insensitive" do
    create_items

    get "/api/v1/items/find?name=shirt"

    expect(response).to be_success
    expect(json_body["name"]).to eq "Shirt"
  end
end

RSpec.describe "GET /api/v1/items/find?description=Socks description" do
  it "returns item with description = Socks description" do
    create_items

    get "/api/v1/items/find?description=Socks%20description"

    expect(response).to be_success
    expect(json_body["description"]).to eq "Socks description"
  end
end

RSpec.describe "GET /api/v1/items/find_all?name=Cummings-Thiel" do
  it "returns all items whose name matches Cummings-Thiel" do
    create_items
    create_items

    get "/api/v1/items/find_all?name=Pants"

    expect(response).to be_success
    expect(json_body.count).to eq 2
  end
end

RSpec.describe "GET api/v1/items/random" do
  it "returns a random item" do
    create_items

    get "/api/v1/items/random"

    expect(response).to be_success
    expect(Item.find(json_body[0]["id"]).valid?).to be true
  end
end

RSpec.describe "GET /api/v1/items/most_revenue?quantity=x" do
  xit "returns the top x items ranked by total revenue" do

    get "/api/v1/items/most_revenue?quantity=2"

    expect(response).to be_success
    expect(json_body.count).to eq 2
  end
end

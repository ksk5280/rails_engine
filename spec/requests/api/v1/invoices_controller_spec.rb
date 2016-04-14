require "rails_helper"
require "test_helper"

RSpec.describe "GET /api/v1/invoices" do
  it "returns a list of invoices" do
    create_invoices

    get "/api/v1/invoices"

    expect(response).to be_success
    expect(json_body.count).to eq(3)
  end
end


RSpec.describe "GET /api/v1/invoices/1" do
  it "returns a single invoice" do
    create_invoices

    get "/api/v1/invoices/#{@inv1.id}"

    expect(response).to be_success
    expect(json_body["status"]).to eq "pending"
  end
end

RSpec.describe "GET /api/v1/invoices/find?status=pending" do
  it "returns invoice with status = pending" do
    create_invoices

    get "/api/v1/invoices/find?status=pending"

    expect(response).to be_success
    expect(json_body["status"]).to eq "pending"
  end
end

def create_invoices
  cust1 = create_customer("Joey", "Ondricka")
  cust2 = create_customer("Cecilia", "Osinski")
  cust3 = create_customer("Mariah", "Toy")
  merc1 = create_merchant("Schroeder-Jerde")
  merc2 = create_merchant("Klein, Rempel and Jones")
  @inv1  = create_invoice(cust1.id, merc1.id, "pending")
  inv2  = create_invoice(cust2.id, merc2.id, "shipped")
  inv2  = create_invoice(cust3.id, merc2.id, "shipped")
end

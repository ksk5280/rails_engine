require "rails_helper"

RSpec.describe Merchant, type: :model do
  it { should have_many(:invoices) }
  it { should have_many(:customers).through(:invoices) }

  it "downcases name before saving" do
    merchant = Merchant.create(name: "Schroeder-Jerde")

    expect(merchant.name).to eq "schroeder-jerde"
  end
end

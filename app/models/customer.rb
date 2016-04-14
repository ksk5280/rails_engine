class Customer < ActiveRecord::Base
  has_many :invoices
  has_many :merchants, through: :invoices
  has_many :transactions, through: :invoices

  # GET /api/v1/customers/:id/favorite_merchant
  # returns a merchant where the customer has conducted the most successful transactions
  def favorite_merchant
    # merchants.
    merchant_id =
      invoices.
        joins(:transactions).
        where(transactions: {result: "success"}).
        group(:merchant_id).
        order("count_id DESC").
        count("id").
        first[0]

    Merchant.find(merchant_id)
  end
end

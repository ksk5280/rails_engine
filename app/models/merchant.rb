class Merchant < ActiveRecord::Base
  has_many :invoices
  has_many :customers, through: :invoices
  before_save :downcase_name

  def downcase_name
    self.name.downcase!
  end

  # GET /api/v1/merchants/most_revenue?quantity=x returns the top x merchants ranked by total revenue
  # def max_revenue(num)
  # end
end

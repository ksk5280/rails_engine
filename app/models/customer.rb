class Customer < ActiveRecord::Base
  has_many :invoices
  has_many :merchants, through: :invoices
  has_many :transactions, through: :invoices
  before_save :downcase_first_name, :downcase_last_name

  def downcase_first_name
    self.first_name.downcase!
  end
  
  def downcase_last_name
    self.last_name.downcase!
  end
end

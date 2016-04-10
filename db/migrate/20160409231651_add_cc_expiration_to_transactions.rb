class AddCcExpirationToTransactions < ActiveRecord::Migration
  def change
    add_column :transactions, :credit_card_expiration_date, :text
  end
end

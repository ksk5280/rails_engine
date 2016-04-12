class AddCitextTypeToTables < ActiveRecord::Migration
  def change
    enable_extension "citext"

    change_column :customers, :first_name, :citext, null: false
    change_column :customers, :last_name, :citext, null: false
    change_column :invoices, :status, :citext, null: false
    change_column :items, :name, :citext, null: false
    change_column :items, :description, :citext
    change_column :transactions, :result, :citext, null: false
  end
end

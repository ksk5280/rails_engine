class AddCitextColumnToMerchants < ActiveRecord::Migration
  def change
    enable_extension "citext"

    change_column :merchants, :name, :citext, null: false
  end
end

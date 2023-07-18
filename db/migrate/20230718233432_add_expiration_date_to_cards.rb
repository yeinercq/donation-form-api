class AddExpirationDateToCards < ActiveRecord::Migration[7.0]
  def change
    add_column :cards, :expiration_date, :date, null: false
  end
end

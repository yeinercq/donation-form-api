class RemoveExpirationDateFromCards < ActiveRecord::Migration[7.0]
  def change
    remove_column :cards, :expiration_date, :string
  end
end

class CreateDonations < ActiveRecord::Migration[7.0]
  enable_extension 'hstore' unless extension_enabled?('hstore')
  def change
    create_table :donations do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :email, null: false
      t.date :birth_date, null: false
      t.string :phone_number, null: false
      t.hstore :options, default: {}
      t.string :status
      t.decimal :amount, precision: 10, scale: 2, null: false

      t.timestamps
    end
  end
end

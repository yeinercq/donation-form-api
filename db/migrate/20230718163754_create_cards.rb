class CreateCards < ActiveRecord::Migration[7.0]
  def change
    create_table :cards do |t|
      t.string :card_number, null: false
      t.string :security_code, null: false
      t.string :expiration_date, null: false
      t.integer :card_type, null: false
      t.integer :document_type, null: false
      t.string :document_number, null: false
      t.references :donation, null: false, foreign_key: true

      t.timestamps
    end
  end
end

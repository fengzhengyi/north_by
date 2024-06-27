class CreateTickets < ActiveRecord::Migration[7.1]
  def change
    create_table :tickets do |t|
      t.references :concert, null: false, foreign_key: true
      t.integer :row
      t.integer :number
      t.references :user, null: false, foreign_key: true
      t.string :status

      t.timestamps
    end
  end
end

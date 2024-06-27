class CreateTicketOrders < ActiveRecord::Migration[7.1]
  def change
    create_table :ticket_orders do |t|
      t.references :concert, null: false, foreign_key: true
      t.string :status
      t.integer :count

      t.timestamps
    end
  end
end

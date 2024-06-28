class CreateShoppingCarts < ActiveRecord::Migration[7.1]
  def change
    create_table :shopping_carts do |t|
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end

    add_reference :tickets, :shopping_cart, foreign_key: true, null: true
    add_reference :ticket_orders, :shopping_cart, foreign_key: true, null: true
  end
end

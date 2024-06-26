class CreateGigs < ActiveRecord::Migration[7.1]
  def change
    create_table :gigs do |t|
      t.references :concert, null: false, foreign_key: true
      t.references :band, null: false, foreign_key: true
      t.integer :order
      t.integer :duration_minutes

      t.timestamps
    end
  end
end

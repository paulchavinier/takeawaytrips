class CreateCards < ActiveRecord::Migration
  def change
    create_table :cards do |t|
      t.string :banner_picture
      t.string :name
      t.string :type
      t.text :formatted_address
      t.string :international_phone_number
      t.string :website
      t.text :opening_hours
      t.integer :price_level
      t.text :personnal_note
      t.references :guide, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end

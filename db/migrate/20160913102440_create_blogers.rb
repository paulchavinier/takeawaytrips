class CreateBlogers < ActiveRecord::Migration
  def change
    create_table :blogers do |t|
      t.string :name
      t.string :author
      t.text :short_desc
      t.text :long_desc
      t.string :location
      t.string :facebook
      t.string :instagram
      t.string :twitter
      t.string :website
      t.string :profile_pic
      t.string :banner

      t.timestamps null: false
    end
  end
end

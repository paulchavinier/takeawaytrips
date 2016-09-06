class AddBlogerToUsers < ActiveRecord::Migration
  def change
    add_column :users, :bloger, :boolean
  end
end

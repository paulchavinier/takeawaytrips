class AddPictureToBloguers < ActiveRecord::Migration
  def change
    add_column :bloguers, :facebook_pic, :string
  end
end

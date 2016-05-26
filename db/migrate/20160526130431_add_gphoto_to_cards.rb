class AddGphotoToCards < ActiveRecord::Migration
  def change
    add_column :cards, :gphoto, :string
  end
end

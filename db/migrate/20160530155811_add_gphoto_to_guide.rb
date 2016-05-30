class AddGphotoToGuide < ActiveRecord::Migration
  def change
    add_column :guides, :gphoto, :string
  end
end

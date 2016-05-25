class AddPhotoToCard < ActiveRecord::Migration
  def change
    add_column :cards, :photo, :string
  end
end

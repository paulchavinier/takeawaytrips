class AddRatingToCards < ActiveRecord::Migration
  def change
    add_column :cards, :rating, :string
  end
end

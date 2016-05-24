class AddPlaceToGuides < ActiveRecord::Migration
  def change
    add_column :guides, :place, :string
  end
end

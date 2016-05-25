class AddPlaceTypeToGuides < ActiveRecord::Migration
  def change
    add_column :guides, :place_type, :string
  end
end

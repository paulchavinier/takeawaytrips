class AddSlugToBloguers < ActiveRecord::Migration
  def change
    add_column :bloguers, :slug, :string
  end
end

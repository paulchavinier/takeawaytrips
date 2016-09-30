class AddCountryToGuides < ActiveRecord::Migration
  def change
    add_column :guides, :country, :string
  end
end

class RemoveCountryToGuides < ActiveRecord::Migration
  def change
    remove_column :guides, :country, :text
  end
end

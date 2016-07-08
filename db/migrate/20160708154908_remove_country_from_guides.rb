class RemoveCountryFromGuides < ActiveRecord::Migration
  def change
    remove_column :guides, :country, :string
  end
end

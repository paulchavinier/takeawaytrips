class AddPrivacyToGuides < ActiveRecord::Migration
  def change
    add_column :guides, :privacy, :string
  end
end

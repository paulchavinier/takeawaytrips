class ChangeTypetoCategory < ActiveRecord::Migration
  def change
    rename_column :cards, :type, :category
  end
end

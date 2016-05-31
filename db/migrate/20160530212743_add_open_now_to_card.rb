class AddOpenNowToCard < ActiveRecord::Migration
  def change
    add_column :cards, :open_now, :boolean
  end
end

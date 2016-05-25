class ChangeFormattedAddressToString < ActiveRecord::Migration
  def change
    change_column :cards, :formatted_address, :string
  end
end

class ChangeCardOpeningHoursToArray < ActiveRecord::Migration
  def change
    change_column :cards, :opening_hours, :string, array: true, default: [], using: "(string_to_array(opening_hours, ','))"
  end
end

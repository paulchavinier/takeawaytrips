class RenameBlogersToBloguers < ActiveRecord::Migration
 def change
    rename_table :blogers, :bloguers
  end
end

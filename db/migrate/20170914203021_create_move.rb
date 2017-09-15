class CreateMove < ActiveRecord::Migration[5.0]
  def change
    create_table :moves do |t|
      t.integer :x_coor
      t.integer :y_coor
      t.integer :game_id
      t.integer :player_id
  end
end

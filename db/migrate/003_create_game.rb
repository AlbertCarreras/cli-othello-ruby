class CreateGame < ActiveRecord::Migration[5.0]
  def change
    create_table :games do |t|
      t.integer :board_id
      t.integer :player_one_id
      t.integer :player_two_id
      t.boolean :player_one_turn
    end
  end
end

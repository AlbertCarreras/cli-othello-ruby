class CreatePlayer < ActiveRecord::Migration[5.1]
  def change
    create_table :players do |t|
      t.string :username
      t.integer :current_chip
      t.integer :wins
      t.integer :losses
    end
  end
end

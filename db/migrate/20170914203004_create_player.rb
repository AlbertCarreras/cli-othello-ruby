class CreatePlayer < ActiveRecord::Migration[5.0]
  def change
    create_table :players do |t|
      t.string :username
      t.integer :chip
      t.integer :wins
      t.integer :losses
      t.boolean :winner, :default => false
  end
end

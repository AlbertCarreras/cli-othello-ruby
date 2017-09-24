class CreatePlayer < ActiveRecord::Migration[5.0]
  def change
    create_table :players do |t|
      t.string :username
      t.integer :chip, default: nil
      t.integer :wins, default: 0
      t.integer :losses, default: 0
    end
  end
end

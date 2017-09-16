class Player < ActiveRecord::Base
  has_many :games, through: :moves
  has_many :moves

  def self.add_player(input_username, chip_type)
    self.create(username: input_username, chip: chip_type)
  end

  def self.retrieve_player(input_username)
    self.find_by(username: input_username)
  end

end

class Player < ActiveRecord::Base
  has_many :games, through: :moves
  has_many :moves

  def self.add_player(input_username)
    self.create(username: input_username)
  end

  def self.retrieve_player(input_username)
    self.find_by(username: input_username)
  end

end

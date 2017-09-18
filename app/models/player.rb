class Player < ActiveRecord::Base
  has_many :boards, through: :games

  def self.add_player(input_username, chip_type)
    self.create(username: input_username, chip: chip_type)
  end

  def self.retrieve_player(input_username)
    self.find_by(username: input_username)
  end

  def make_move(input)
    y_coor = input.split("")[0].to_i
    x_coor = input.split("")[1].to_i

    move = Move.new(x_coor: x_coor, y_coor: y_coor)
    valid = move.check_move(self)
  end

end

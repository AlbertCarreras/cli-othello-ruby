class Player < ActiveRecord::Base

  def self.add_player(input_username)
    self.create(username: input_username)
  end

  def self.retrieve_player(input_username)
    self.find_by(username: input_username)
  end

  def make_move(input)
    y_coor = input.split("")[0].to_i

    case input.split("")[1]
      when "a"
        x_coor = 0
      when "b"
        x_coor = 1
      when "c"
        x_coor = 2
      when "d"
        x_coor = 3
      when "e"
        x_coor = 4
      when "f"
        x_coor = 5
      when "g"
        x_coor = 6
      when "h"
        x_coor = 7
    end

    move = Move.new(x_coor: x_coor, y_coor: y_coor)
    valid = move.check_move(self)
  end

end

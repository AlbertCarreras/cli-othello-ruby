class Move
  attr_reader :x_coor, :y_coor

  @@all = []

  def initialize(x_coor:, y_coor:)
    @x_coor = x_coor
    @y_coor = y_coor
    @@all << self
  end

  def self.all
    @@all
  end

  def opp_chip?(same_chip, opp_chip, player, board, direction)
    board_string = board.to_s
    test_board = eval(board_string)
    if test_board.[](self.y_coor, self.x_coor) == 7
      x_check = self.x_coor + direction[0]
      y_check = self.y_coor + direction[1]
      if x_check >= 0 && x_check < 8 && y_check >= 0 && y_check < 8

        chips_to_change = []
        chips_to_change << [self.y_coor, self.x_coor]
        cell_check = test_board.[](y_check, x_check)
        chips_to_change << [y_check, x_check]

        until cell_check == same_chip || cell_check == 7
          x_check += direction[0]
          y_check += direction[1]
          break if x_check < 0 || x_check > 8 || y_check < 0 || y_check > 8

          cell_check = test_board.[](y_check, x_check)

          if cell_check == opp_chip
            chips_to_change << [y_check, x_check]
          elsif cell_check == same_chip
            if player.class == Player
              self.execute_move(chip: same_chip, chips_to_change: chips_to_change)
              return true
            elsif player.class == CPU
              return chips_to_change
            end
          end
        end
      end
    end
  end

  def get_chip_types(player)
    chips = {
      same: player.current_chip,
      opp: (player.current_chip - 1).abs
    }
  end

  def directions
    direction = {
      up: [0,-1],
      down: [0,1],
      left: [-1, 0],
      right: [1,0],
      up_left: [-1, -1],
      up_right: [1, -1],
      down_left: [-1, 1],
      down_right: [1, 1]}
  end

  def check_move(player)
    chips = get_chip_types(player)
    valid = []
    board = eval(Board.last.matrix_string)
    direction = self.directions

    direction.each do |key, values|
      valid << self.opp_chip?(chips[:same], chips[:opp], player, board, values)
    end

    if valid.include?(true) && player.class == Player
      return true
    elsif player.class == CPU
      return valid
    else
      return nil
    end
  end

  def execute_move(chip:, chips_to_change:)
    board = eval(Board.last.matrix_string)

    chips_to_change.each do |change_chip|
      board.send(:[]=, change_chip[0], change_chip[1], chip)
    end
    matrix_string = board.to_s
    Board.last.matrix_string = matrix_string

  end

end

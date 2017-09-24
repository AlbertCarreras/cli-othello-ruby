require 'pry'

class CPU
  attr_accessor :current_chip

  @@all = []

  def initialize(current_chip:)
    @current_chip = current_chip
    @@all << self
  end

  def self.last
    @@all[-1]
  end

  def get_total_score(board)
    count = {
      zero: 0,
      one: 0
    }
    board.each do |cell|
      if cell == 0
        count[:zero] += 1
      elsif cell == 1
        count[:one] += 1
      end
    end
    count
  end

  def greatest_lead_response(board, chip, player)
    if player == "human"
      self.current_chip = (self.current_chip - 1).abs
    else
      self.current_chip = (self.current_chip - 1).abs
    end

    x = 0
    y = 0
    t = 0
    final_change_array = {}
    board_string = board.to_s
    test_board = eval(board_string)

    while x < 8
      while y < 8
        move = Move.new(x_coor: x, y_coor: y)
        change_array = move.check_move(self)
        if change_array.compact.length > 0
          binding.pry
          # final_change_array << change_array
          change_array.compact.flatten(1).each do |chips|
            test_board.send(:[]=, chips[0], chips[1], self.current_chip)
          end

          # get total score
          count = self.get_total_score(test_board)
          final_change_array["test_board_#{t}".to_sym] = {
            chips_to_change: change_array,
            count: count
          }
          t += 1
        end
        y += 1
      end
      x += 1
      y = 0
    end

    # return move that is most advantagous

    
    binding.pry
  end

  def make_move
    x = 3
    y = 5
    final_change_array = []
    board_string = Board.last.matrix_string
    test_board = eval(board_string)

    while x < 8
      while y < 8
        # check for viable moves
          move = Move.new(x_coor: x, y_coor: y)
          change_array = move.check_move(self).compact.flatten(1)
          if change_array.length > 0
            final_change_array << change_array
            change_array.each do |chips|
              test_board.send(:[]=, chips[0], chips[1], self.current_chip)
            end
          end


        # guess human response
        test_board = self.greatest_lead_response(test_board, (self.current_chip - 1).abs, "human")

        # respond with highest separation of chips
        test_board = self.greatest_lead_response(test_board, self.current_chip, "cpu")
          # take total score

        y += 1
      end
      x += 1
    end

    # choose original viable man with most favorable total score


  end

end

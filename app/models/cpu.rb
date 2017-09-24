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
    final_change_hash = {}
    board_string = board.to_s
    # test_board = eval(board_string)

    while x < 8
      while y < 8
        test_board = eval(board_string)
        move = Move.new(x_coor: x, y_coor: y)
        change_array = move.check_move(self)
        if change_array.compact.length > 0
          # final_change_hash << change_array
          change_array.compact.flatten(1).each do |chips|
            test_board.send(:[]=, chips[0], chips[1], self.current_chip)
          end

          # get total score
          count = self.get_total_score(test_board)
          final_change_hash["test_board_#{t}".to_sym] = {
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
    max = -100
    spread = ""
    final_chips_to_change = []
    final_change_hash.each do |test_board, data|
      if self.current_chip == 0
        spread = data[:count][:zero] - data[:count][:one]
      else
        spread = data[:count][:one] - data[:count][:zero]
      end

      if spread > max
        max = spread
        final_chips_to_change = data[:chips_to_change].compact.flatten(1)
      end
    end

    if final_chips_to_change.length > 0
      final_chips_to_change.each do |chips|
        board.send(:[]=, chips[0], chips[1], self.current_chip)
      end
    end
    board
  end

  def make_move
    x = 3
    y = 5
    t = 0
    final_change_hash = {}
    board_string = Board.last.matrix_string
    test_board = eval(board_string)

    while x < 8
      while y < 8
        # check for viable moves
          move = Move.new(x_coor: x, y_coor: y)
          change_array = move.check_move(self).compact.flatten(1)
          if change_array.length > 0
            change_array.each do |chips|
              test_board.send(:[]=, chips[0], chips[1], self.current_chip)
            end
            # guess human response
            test_board = self.greatest_lead_response(test_board, (self.current_chip - 1).abs, "human")
            # respond with highest separation of chips
            test_board = self.greatest_lead_response(test_board, self.current_chip, "cpu")
              # take total score
              count = self.get_total_score(test_board)
              # enter score into final_change_hash
              final_change_hash["test_#{t}".to_sym] = {
                change_array: change_array,
                lead: count[:one] - count[:zero]
              }

            t += 1
          end

        y += 1
      end
      y = 0
      x += 1
    end

    # choose original viable man with most favorable total score
    max = -100
    spread = ""
    final_chips_to_change = []
    final_change_hash.each do |test_board, data|
      spread = data[:lead]

      if spread > max
        max = spread
        final_chips_to_change = data[:change_array]
      end
    end
    binding.pry

  end

end

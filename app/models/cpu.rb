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

  def make_move(final_change_hash, testing)
    max = -100
    spread = ""
    final_chips_to_change = []
    final_change_hash.each do |test_board, data|
      if testing == false
        spread = data[:lead]
      else
        if self.current_chip == 0
          spread = data[:lead]
        else
          spread = (-1) * data[:lead]
        end
      end

      if spread > max
        max = spread
        final_chips_to_change = data[:change_array]
      end
    end
    final_chips_to_change
  end

  def update_board(final_chips_to_change, board)
    if final_chips_to_change.length > 0
      final_chips_to_change.each do |chips|
        board.send(:[]=, chips[0], chips[1], self.current_chip)
      end
    end
    board
  end

  def greatest_lead_response(board, chip)
    x, y, t = 0, 0, 0
    final_change_hash = {}
    board_string = board.to_s

    while x < 8
      while y < 8
        #######################################
        test_board = eval(board_string)
        move = Move.new(x_coor: x, y_coor: y)
        change_array = move.check_move(self).compact.flatten(1)
        #######################################
        if change_array.length > 0
          change_array.compact.flatten(1).each do |chips|
            test_board.send(:[]=, chips[0], chips[1], self.current_chip)
          end

          # get total score
          count = Board.get_chip_count(test_board)
          final_change_hash["test_board_#{t}".to_sym] = {
            change_array: change_array,
            lead: count[:one] - count[:zero]
          }
          t += 1
          #######################################
        end
        y += 1
      end
      x += 1
      y = 0
    end

    final_chips_to_change = self.make_move(final_change_hash, true)
    updated_board = self.update_board(final_chips_to_change, board)
  end

  def find_move
    x, y, t = 0, 0, 0
    final_change_hash = {}
    board_string = Board.last.matrix_string

    while x < 8
      while y < 8
        # check for viable moves
          #######################################
          test_board = eval(board_string)
          move = Move.new(x_coor: x, y_coor: y)
          change_array = move.check_move(self).compact.flatten(1)

          if change_array.length > 0
            change_array.each do |chips|
              test_board.send(:[]=, chips[0], chips[1], self.current_chip)
            end
            # guess human response
            test_board1 = self.greatest_lead_response(test_board, (self.current_chip - 1).abs)
            # respond with highest separation of chips
            test_board2 = self.greatest_lead_response(test_board1, self.current_chip)
              # take total score
              count = Board.get_chip_count(test_board2)
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
    final_chips_to_change = self.make_move(final_change_hash, false)
    #####################
    board = eval(board_string)
    updated_board =  self.update_board(final_chips_to_change, board)
    Board.last.matrix_string = updated_board.to_s
  end

end

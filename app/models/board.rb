require 'pry'
require 'matrix'

class Board < ActiveRecord::Base
  belongs_to :game
  belongs_to :player, foreign_key: "player_one_id"
  belongs_to :player, foreign_key: "player_two_id"

    @@str00 = "         1   2   3   4   5   6   7   8"
    @@stryy = "        ___ ___ ___ ___ ___ ___ ___ ___"
    @@stry1 = "     1 |   |   |   |   |   |   |   |   "
    @@stry2 = "     2 |   |   |   |   |   |   |   |   "
    @@stry3 = "     3 |   |   |   |   |   |   |   |   "
    @@stry4 = "     4 |   |   |   | 1 | 0 |   |   |   "
    @@stry5 = "     5 |   |   |   | 0 | 1 |   |   |   "
    @@stry6 = "     6 |   |   |   |   |   |   |   |   "
    @@stry7 = "     7 |   |   |   |   |   |   |   |   "
    @@stry8 = "     8 |   |   |   |   |   |   |   |   "


  def self.new_board
    matrix = Matrix.[](
      [7, 7, 7, 7, 7, 7, 7, 7],
      [7, 7, 7, 7, 7, 7, 7, 7],
      [7, 7, 7, 7, 7, 7, 7, 7],
      [7, 7, 7, 1, 0, 7, 7, 7],
      [7, 7, 7, 0, 1, 7, 7, 7],
      [7, 7, 7, 7, 7, 7, 7, 7],
      [7, 7, 7, 7, 7, 7, 7, 7],
      [7, 7, 7, 7, 7, 7, 7, 7])
    Board.new(matrix_string: matrix.to_s)
  end

  def self.get_chip_count

  end

  def to_printable_board
    puts "           _   _          _ _     "
    puts "          | | | |        | | |      "
    puts "      ___ | |_| |__   ___| | | ___  "
    puts "     / _ \\\| __| '_ \\ / _ \\ | |/ _ \\ "
    puts "    | (_) | |_| | | |  __/ | | (_) |"
    puts "     \\___/ \\__|_| |_|\\___|_|_|\\___/ "
    puts "\n"

    i = 0
    j = 0
    puts "     a   b   c   d   e   f   g   h "
    puts "    ___ ___ ___ ___ ___ ___ ___ ___"
    self.each do |cell|
      if cell == nil
        cell = " "
      end
      if i == 0
        print " #{j + 1} "
      end
      print "| " + cell.to_s + " "
      i+= 1
      if i == self.column_size
        print "\n"
        print "    ___ ___ ___ ___ ___ ___ ___ ___"
        puts "\n"
        i = 0
        j += 1
      end
    end
    puts "\n"
  end


  def self.display_board

    #counts = self.get_chip_count
    puts "             _   _          _ _     "
    puts "            | | | |        | | |      "
    puts "        ___ | |_| |__   ___| | | ___  "
    puts "       / _ \\\| __| '_ \\ / _ \\ | |/ _ \\ "
    puts "      | (_) | |_| | | |  __/ | | (_) |"
    puts "       \\___/ \\__|_| |_|\\___|_|_|\\___/ "
    puts "\n"
    #display the count of 1's and 0's
    #puts "        Player 1: #{counts[:zero]}      Player 2: #{counts[:one]}"
    puts "\n"
    puts str00
    puts stryy
    puts stry1
    puts stryy
    puts stry2
    puts stryy
    puts stry3
    puts stryy
    puts stry4
    puts stryy
    puts stry5
    puts stryy
    puts stry6
    puts stryy
    puts stry7
    puts stryy
    puts stry8
    puts stryy
  end

end

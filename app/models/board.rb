require 'matrix'
require 'pry'
class Board < Matrix

  def self.new_board
    binding.pry
    self.[](
      [nil, nil, nil, nil, nil, nil, nil, nil],
      [nil, nil, nil, nil, nil, nil, nil, nil],
      [nil, nil, nil, nil, nil, nil, nil, nil],
      [nil, nil, nil, 1, 0, nil, nil, nil],
      [nil, nil, nil, 0, 1, nil, nil, nil],
      [nil, nil, nil, nil, nil, nil, nil, nil],
      [nil, nil, nil, nil, nil, nil, nil, nil],
      [nil, nil, nil, nil, nil, nil, nil, nil])
  end

end

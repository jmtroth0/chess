require_relative 'sliding_piece'
require_relative 'stepping_piece'

class Board
  BOARD_SIZE = 8

  def initialize
    @grid = Array.new(BOARD_SIZE) { Array.new(BOARD_SIZE) }
  end

  def [](pos)
    @grid[pos[0]][pos[1]]
  end

  def []=(pos, value)
    @grid[pos[0]][pos[1]] = value
  end

  def empty?(pos)
    self[pos].nil?
  end

  def on_board?(pos)
    pos.all? { |coord| coord.between?(0, BOARD_SIZE - 1) }
  end

  def color_at(pos)
    self[pos].color
  end

  def piece_at?(pos)
    on_board?(pos) && self[pos]
  end
end

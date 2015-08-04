require_relative 'sliding_piece'
require_relative 'stepping_piece'
require_relative 'pawn'

class Board
  BOARD_SIZE = 8
  INITIAL_POSITIONS = {
    [0, 0] => Rook,
    [0, 1] => Knight,
    [0, 2] => Bishop,
    [0, 3] => Queen,
    [0, 4] => King,
    [0, 5] => Bishop,
    [0, 6] => Knight,
    [0, 7] => Rook,
  }

  def initialize
    @grid = Array.new(BOARD_SIZE) { Array.new(BOARD_SIZE) }
    setup
  end

  def setup
    setup_pawns
    setup_non_pawns
    nil
  end

  def setup_pawns
    (0...BOARD_SIZE).each do |col|
      white_pos = [1, col]
      self[white_pos] = Pawn.new(white_pos, self, :white)
      black_pos = [BOARD_SIZE - 2, col]
      self[black_pos] = Pawn.new(black_pos, self, :black)
    end

    nil
  end

  def setup_non_pawns
    INITIAL_POSITIONS.each do |pos, type|
      self[pos] = type.new(pos, self, :white)
      pos_for_black = [pos[0] + BOARD_SIZE - 1, pos[1]]
      self[pos_for_black] = type.new(pos_for_black, self, :black)
    end

    nil
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

  def available_space?(pos)
     on_board?(pos) && !piece_at?(pos)
  end
  
end

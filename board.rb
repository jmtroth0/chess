require_relative 'sliding_piece'
require_relative 'stepping_piece'
require_relative 'pawn'
require 'colorize'

class Board
  BOARD_SIZE = 8
  INITIAL_POSITIONS = [
    Rook,
    Knight,
    Bishop,
    Queen,
    King,
    Bishop,
    Knight,
    Rook
  ]

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
    INITIAL_POSITIONS.each_with_index do |type, col|
      white_pos = [0,col]
      self[white_pos] = type.new(white_pos, self, :white)
      black_pos = [BOARD_SIZE - 1, col]
      self[black_pos] = type.new(black_pos, self, :black)
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
    on_board?(pos) && !empty?(pos)
  end

  def available_space?(pos)
    on_board?(pos) && empty?(pos)
  end

  def render
    puts
    rows.reverse.each_with_index do |row, i|
      puts "#{BOARD_SIZE - i}".colorize(:blue) + "  #{row.join("")}"
    end
    puts "\n    #{("A".."H").to_a.join("  ")}".colorize(:blue)
  end

  def rows
    @grid
  end
end

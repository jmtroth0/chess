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

  def self.setup_new_board
    board = new
    board.setup
    board
  end

  def initialize
    @grid = Array.new(BOARD_SIZE) { Array.new(BOARD_SIZE) }
  end

  def ==(other_board)
    (0...BOARD_SIZE).each do |row_index|
      (0...BOARD_SIZE).each do |col_index|
        pos = [row_index, col_index]
        return false unless self[pos].class == other_board[pos].class
      end
    end

    true
  end

  def setup
    setup_pawns
    setup_non_pawns
    nil
  end

  def move(start_pos, end_pos)
    self[start_pos].move_to(end_pos)
    move_on_grid(start_pos, end_pos)
  end

  def move!(start_pos, end_pos)
    self[start_pos].move_to!(end_pos)
    move_on_grid(start_pos, end_pos)
  end

  def possible_moves(color)
    moves = []

    pieces_of_color(color).each do |piece|
      piece.valid_moves.each do |end_pos|
        moves << [piece.pos, end_pos]
      end
    end

    moves
  end

  def check_mate?(color)
    in_check?(color) && pieces.all? do |piece|
      piece.color == :black || piece.valid_moves.empty?
    end
  end

  def in_check?(color)
    king_pos = king_position(color)
    pieces.any? { |piece| piece.moves.include?(king_pos) }
  end

  def on_board?(pos)
    pos.all? { |coord| coord.between?(0, BOARD_SIZE - 1) }
  end

  def empty_square?(pos)
    on_board?(pos) && self[pos].nil?
  end

  def piece_at?(pos)
    on_board?(pos) && !self[pos].nil?
  end

  def color_at(pos)
    self[pos].color
  end

  def dup
    new_board = Board.new
    pieces.each { |piece| piece.dup(new_board) }
    new_board
  end

  def render
    puts "\n"
    rows.reverse.each_with_index do |row, i|
      rendered_row = row.map { |tile| tile.nil? ? "[ ]" : tile }.join("")
      puts "#{BOARD_SIZE - i}".colorize(:blue) + "  #{rendered_row}"
    end
    puts "\n    #{("A".."H").to_a.join("  ")}".colorize(:blue)
  end

  def pieces
    rows.flatten.compact
  end

  def []=(pos, value)
    @grid[pos[0]][pos[1]] = value
  end

  protected

  def [](pos)
    @grid[pos[0]][pos[1]]
  end

  private

  def rows
    @grid
  end

  def king_position(color)
    pieces.each do |piece|
      return piece.pos if piece.is_a?(King) && piece.color == color
    end
  end

  def move_on_grid(start_pos, end_pos)
    self[end_pos], self[start_pos] = self[start_pos], nil
  end

  def setup_pawns
    (0...BOARD_SIZE).each do |col|
      Pawn.new([1, col], self, :white)
      Pawn.new([BOARD_SIZE - 2, col], self, :black)
    end

    nil
  end

  def setup_non_pawns
    INITIAL_POSITIONS.each_with_index do |type, col|
      type.new([0, col], self, :white)
      type.new([BOARD_SIZE - 1, col], self, :black)
    end

    nil
  end

  def pieces_of_color(color)
    pieces.select { |piece| piece.color == color }
  end
end

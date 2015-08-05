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

    pieces.each do |piece|
      new_piece = piece.class.new(piece.pos.dup, new_board, piece.color)
      new_board[piece.pos] = new_piece
    end

    new_board
  end

  def render
    system("clear")
    rows.reverse.each_with_index do |row, i|
      rendered_row = row.map { |tile| tile.nil? ? "[ ]" : tile }.join("")
      puts "#{BOARD_SIZE - i}".colorize(:blue) + "  #{rendered_row}"
    end
    puts "\n    #{("A".."H").to_a.join("  ")}".colorize(:blue)
  end

  protected

  def [](pos)
    @grid[pos[0]][pos[1]]
  end

  def []=(pos, value)
    @grid[pos[0]][pos[1]] = value
  end

  private

  def rows
    @grid
  end

  def pieces
    rows.flatten.compact
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
      self[[1, col]] = Pawn.new([1, col], self, :white)
      self[[BOARD_SIZE - 2, col]] = Pawn.new([BOARD_SIZE - 2, col], self, :black)
    end

    nil
  end

  def setup_non_pawns
    INITIAL_POSITIONS.each_with_index do |type, col|
      self[[0, col]] = type.new([0, col], self, :white)
      self[[BOARD_SIZE - 1, col]] = type.new([BOARD_SIZE - 1, col], self, :black)
    end

    nil
  end
end

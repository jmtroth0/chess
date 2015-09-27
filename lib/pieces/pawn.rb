require_relative 'piece'

class Pawn < Piece
  REPRESENTATION = {:white => "\u2659", :black => "\u265F"}
  POINTS = 1

  def initialize(pos, board, color)
    super(pos, board, color)
    @has_moved = false
  end

  def moves
    non_taking_moves + taking_moves
  end

  private

  def taking_moves
    deltas_for_taking.map do |delta|
      Piece.add_delta(pos, delta)
    end.select { |move| board.piece_at?(move) && board.color_at(move) != color}
  end

  def non_taking_moves
    moves = []

    move = Piece.add_delta(pos, delta_for_moving)
    if board.empty_square?(move)
      moves << move

      second_move = Piece.add_delta(move, delta_for_moving)
      moves << second_move if !has_moved? && board.empty_square?(second_move)
    end

    moves
  end

  def has_moved?
    @has_moved
  end

  def delta_for_moving
    color == :white ? [1, 0] : [-1, 0]
  end

  def deltas_for_taking
    color == :white ? [[1, 1], [1, -1]] : [[-1, 1], [-1, -1]]
  end
end

require_relative 'piece'

class Pawn < Piece

  def initialize(pos, board, color)
    super(pos, board, color)
    @has_moved = false
  end

  def has_moved?
    @has_moved
  end

  def moves
    non_taking_moves + taking_moves
  end

  def non_taking_moves
    moves = []

    move = Piece.add_direction(pos, non_taking_direction)
    if board.available_space?(move)
      moves << move

      unless has_moved?
        second_move = Piece.add_direction(move, non_taking_direction)
        if board.available_space?(second_move)
          moves << second_move
        end
      end

    end
    moves
  end

  def taking_moves
    taking_directions.map do |direction|
      Piece.add_direction(pos, direction)
    end.select { |move| board.piece_at?(move) && board.color_at(move) != color}
  end

  def non_taking_direction
    color == :black ? [1, 0] : [-1, 0]
  end

  def taking_directions
    color == :black ? [[1, 1], [1, -1]] : [[-1, 1], [-1, -1]]
  end

  def to_s
    " P "
  end
end

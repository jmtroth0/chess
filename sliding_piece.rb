require_relative 'piece'

class SlidingPiece < Piece
  def moves
    moves = []

    self.class::DIRECTIONS.each do |direction|
      move = Piece.add_direction(pos, direction)
      while board.empty_square?(move)
        moves << move
        move = Piece.add_direction(move, direction)
      end

      moves << move if board.piece_at?(move) && board.color_at(move) != color
    end

    moves
  end
end

class Bishop < SlidingPiece
  DIRECTIONS = [[1,1], [1,-1], [-1,1], [-1,-1]]
  REPRESENTATION = "B"

  def initialize(pos, board, color)
    super(pos, board, color)
  end
end

class Rook < SlidingPiece
  DIRECTIONS = [[1,0], [0,-1], [-1,0], [0,1]]
  REPRESENTATION = "R"

  def initialize(pos, board, color)
    super(pos, board, color)
  end
end

class Queen < SlidingPiece
  DIRECTIONS = [[1,0], [0,-1], [-1,0], [0,1], [1,1], [1,-1], [-1,1], [-1,-1]]
  REPRESENTATION = "Q"

  def initialize(pos, board, color)
    super(pos, board, color)
  end
end

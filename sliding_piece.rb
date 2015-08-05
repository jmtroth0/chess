require_relative 'piece'

class SlidingPiece < Piece
  def moves
    moves = []

    self.class::DELTAS.each do |delta|
      move = Piece.add_delta(pos, delta)
      while board.empty_square?(move)
        moves << move
        move = Piece.add_delta(move, delta)
      end

      moves << move if board.piece_at?(move) && board.color_at(move) != color
    end

    moves
  end
end

class Bishop < SlidingPiece
  DELTAS = [[1,1], [1,-1], [-1,1], [-1,-1]]
  REPRESENTATION = "B"

  def initialize(pos, board, color)
    super(pos, board, color)
  end
end

class Rook < SlidingPiece
  DELTAS = [[1,0], [0,-1], [-1,0], [0,1]]
  REPRESENTATION = "R"

  def initialize(pos, board, color)
    super(pos, board, color)
  end
end

class Queen < SlidingPiece
  DELTAS = [[1,0], [0,-1], [-1,0], [0,1], [1,1], [1,-1], [-1,1], [-1,-1]]
  REPRESENTATION = "Q"

  def initialize(pos, board, color)
    super(pos, board, color)
  end
end

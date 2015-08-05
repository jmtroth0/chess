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
  REPRESENTATION = {:white => "\u2657", :black => "\u265D"}
  POINTS = 6

  def initialize(pos, board, color)
    super(pos, board, color)
  end
end

class Rook < SlidingPiece
  DELTAS = [[1,0], [0,-1], [-1,0], [0,1]]
  REPRESENTATION = {:white => "\u2656", :black => "\u265C"}
  POINTS = 10

  def initialize(pos, board, color)
    super(pos, board, color)
  end
end

class Queen < SlidingPiece
  DELTAS = [[1,0], [0,-1], [-1,0], [0,1], [1,1], [1,-1], [-1,1], [-1,-1]]
  REPRESENTATION = {:white => "\u2655", :black => "\u265B"}
  POINTS = 20

  def initialize(pos, board, color)
    super(pos, board, color)
  end
end

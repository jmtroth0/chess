require_relative 'piece'

class SteppingPiece < Piece
  def moves
    moves = []

    self.class::DELTAS.each do |delta|
      move = Piece.add_delta(pos, delta)
      if board.on_board?(move)
        moves << move if !board.piece_at?(move) || board.color_at(move) != color
      end
    end

    moves
  end
end

class Knight < SteppingPiece
  DELTAS = [[-2,  1], [-1,  2], [ 1,  2], [ 2,  1],
                 [ 2, -1], [ 1, -2], [-1, -2], [-2, -1]]
  REPRESENTATION = {:white => "\u2658", :black => "\u265E"}

  def initialize(pos, board, color)
    super(pos, board, color)
  end
end

class King < SteppingPiece
  DELTAS = [[1,0], [0,-1], [-1,0], [0,1], [1,1], [1,-1], [-1,1], [-1,-1]]
  REPRESENTATION = {:white => "\u2654", :black => "\u265A"}

  def initialize(pos, board, color)
    super(pos, board, color)
  end
end

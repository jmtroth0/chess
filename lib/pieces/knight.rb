require_relative 'stepping_piece'

class Knight < SteppingPiece
  DELTAS = [[-2,  1], [-1,  2], [ 1,  2], [ 2,  1],
                 [ 2, -1], [ 1, -2], [-1, -2], [-2, -1]]
  REPRESENTATION = {:white => "\u2658", :black => "\u265E"}
  POINTS = 2

  def initialize(pos, board, color)
    super(pos, board, color)
  end
end

require_relative 'sliding_piece'

class Bishop < SlidingPiece
  DELTAS = [[1,1], [1,-1], [-1,1], [-1,-1]]
  REPRESENTATION = {:white => "\u2657", :black => "\u265D"}
  POINTS = 6

  def initialize(pos, board, color)
    super(pos, board, color)
  end
end

require_relative 'stepping_piece'

class King < SteppingPiece
  DELTAS = [[1,0], [0,-1], [-1,0], [0,1], [1,1], [1,-1], [-1,1], [-1,-1]]
  REPRESENTATION = {:white => "\u2654", :black => "\u265A"}
  POINTS = 25

  def initialize(pos, board, color)
    super(pos, board, color)
  end
end

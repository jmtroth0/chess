require_relative 'sliding_piece'

class Queen < SlidingPiece
  DELTAS = [[1,0], [0,-1], [-1,0], [0,1], [1,1], [1,-1], [-1,1], [-1,-1]]
  REPRESENTATION = {:white => "\u2655", :black => "\u265B"}
  POINTS = 20

  def initialize(pos, board, color)
    super(pos, board, color)
  end
end

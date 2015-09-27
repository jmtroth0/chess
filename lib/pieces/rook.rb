require_relative 'sliding_piece'

class Rook < SlidingPiece
  DELTAS = [[1,0], [0,-1], [-1,0], [0,1]]
  REPRESENTATION = {:white => "\u2656", :black => "\u265C"}
  POINTS = 10

  def initialize(pos, board, color)
    super(pos, board, color)
  end
end

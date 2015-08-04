class Piece
  attr_reader :pos, :board

  def initialize(pos, board)
    @pos = pos
    @board = board
  end
end

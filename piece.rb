class Piece
  attr_reader :pos, :board, :directions

  def initialize(pos, board)
    @pos = pos
    @board = board
  end

  def self.add_direction(pos, direction)
    [pos[0] + direction[0], pos[1] + direction[1]]
  end
end

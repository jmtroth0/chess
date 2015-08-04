class Piece
  attr_reader :pos, :board, :color

  def initialize(pos, board, color)
    @pos = pos
    @board = board
    @color = color
  end

  def self.add_direction(pos, direction)
    [pos[0] + direction[0], pos[1] + direction[1]]
  end

  def inspect
    to_s
  end
end

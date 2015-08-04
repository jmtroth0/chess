require_relative 'piece'

class Pawn < Piece

  def initialize(pos, board, color)
    super(pos, board, color)
    @has_moved = false
  end

  def has_moved?
    @has_moved
  end

  def move_directions
    if has_moved?
      color == :black ? [[1, 0]] : [[-1, 0]]
    else
      color == :black ? [[1, 0], [2, 0]] : [[-1, 0], [-2, 0]]
    end
  end

  def take_directions
    color == :black ? [[1, 1], [1, -1]] : [[-1, 1], [-1, -1]]
  end

  def to_s
    " P "
  end
end

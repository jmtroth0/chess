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
    [pos, color, self.class].inspect
  end

  def move_to(end_pos)
    if valid_moves.include?(end_pos)
      @pos = end_pos
    else
      raise InvalidMove.new("Invalid move!")
    end
  end

  def move_to!(end_pos)
    @pos = end_pos
  end

  def to_s
    self.class::REPRESENTATION.colorize(color)
  end

  def valid_moves
    moves.select do |move|
      dupped_board = board.dup
      dupped_board.move!(pos, move)
      !dupped_board.in_check?(color)
    end
  end
end

class InvalidMove < StandardError
end

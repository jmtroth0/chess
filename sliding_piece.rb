require_relative 'piece'

class SlidingPiece < Piece
  def moves
    moves = []

    directions.each do |direction|
      move = pos
      while board.on_board?(move) && board.empty?(move)
        moves << move unless move == pos
        move = Piece.add_direction(move, direction)
      end
    end

    moves
  end
end

class Bishop < SlidingPiece

  def initialize(pos, board)
    super(pos, board)
    @directions = [[1,1], [1,-1], [-1,1], [-1,-1]]
  end

  def to_s
    " B "
  end

  def inspect
    " B "
  end
end

class Rook < SlidingPiece

  def initialize(pos, board)
    super(pos, board)
    @directions = [[1,0], [0,-1], [-1,0], [0,1]]
  end

  def to_s
    " R "
  end

  def inspect
    " R "
  end
end

class Queen < SlidingPiece

  def initialize(pos, board)
    super(pos, board)
    @directions = [[1,0], [0,-1], [-1,0], [0,1], [1,1], [1,-1], [-1,1], [-1,-1]]
  end

  def to_s
    " Q "
  end

  def inspect
    " Q "
  end
end

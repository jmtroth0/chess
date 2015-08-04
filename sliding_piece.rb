require_relative 'piece'

class SlidingPiece < Piece
  attr_reader :directions
  
  def moves
    moves = []

    directions.each do |direction|
      move = Piece.add_direction(pos, direction)
      while board.on_board?(move) && board.empty?(move)
        moves << move
        move = Piece.add_direction(move, direction)
      end

      moves << move if board.piece_at?(move) && board.color_at(move) != color
    end

    moves
  end
end

class Bishop < SlidingPiece

  def initialize(pos, board, color)
    super(pos, board, color)
    @directions = [[1,1], [1,-1], [-1,1], [-1,-1]]
  end

  def to_s
    " B "
  end
end

class Rook < SlidingPiece

  def initialize(pos, board, color)
    super(pos, board, color)
    @directions = [[1,0], [0,-1], [-1,0], [0,1]]
  end

  def to_s
    " R "
  end
end

class Queen < SlidingPiece

  def initialize(pos, board, color)
    super(pos, board, color)
    @directions = [[1,0], [0,-1], [-1,0], [0,1], [1,1], [1,-1], [-1,1], [-1,-1]]
  end

  def to_s
    " Q "
  end
end

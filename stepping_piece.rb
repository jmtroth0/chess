require_relative 'piece'

class SteppingPiece < Piece
  attr_reader :directions
  
  def moves
    moves = []

    directions.each do |direction|
      move = Piece.add_direction(pos, direction)
      if board.on_board?(move)
        moves << move if !board.piece_at?(move) || board.color_at(move) != color
      end
    end

    moves
  end
end

class Knight < SteppingPiece

  def initialize(pos, board, color)
    super(pos, board, color)
    @directions = [[-2,1], [-1,2], [1,2], [2,1], [2,-1], [1,-2], [-1,-2], [-2,-1]]
  end

  def to_s
    " N "
  end
end

class King < SteppingPiece

  def initialize(pos, board, color)
    super(pos, board, color)
    @directions = [[1,0], [0,-1], [-1,0], [0,1], [1,1], [1,-1], [-1,1], [-1,-1]]
  end

  def to_s
    " K "
  end
end

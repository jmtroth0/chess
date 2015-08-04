require_relative 'piece'

class SlidingPiece < Piece
  attr_reader :directions

  def moves
    moves = []

    self.class::DIRECTIONS.each do |direction|
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
  DIRECTIONS = [[1,1], [1,-1], [-1,1], [-1,-1]]

  def initialize(pos, board, color)
    super(pos, board, color)
  end

  def representation
    " B "
  end
end

class Rook < SlidingPiece
  DIRECTIONS = [[1,0], [0,-1], [-1,0], [0,1]]

  def initialize(pos, board, color)
    super(pos, board, color)
  end

  def representation
    " R "
  end
end

class Queen < SlidingPiece
  DIRECTIONS = [[1,0], [0,-1], [-1,0], [0,1], [1,1], [1,-1], [-1,1], [-1,-1]]

  def initialize(pos, board, color)
    super(pos, board, color)
  end

  def representation
    " Q "
  end
end

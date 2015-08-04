require_relative 'piece'

class SteppingPiece < Piece
  attr_reader :directions

  def moves
    moves = []

    self.class::DIRECTIONS.each do |direction|
      move = Piece.add_direction(pos, direction)
      if board.on_board?(move)
        moves << move if !board.piece_at?(move) || board.color_at(move) != color
      end
    end

    moves
  end
end

class Knight < SteppingPiece
  DIRECTIONS = [[-2,  1], [-1,  2], [ 1,  2], [ 2,  1],
                 [ 2, -1], [ 1, -2], [-1, -2], [-2, -1]]
  REPRESENTATION = " N "

  def initialize(pos, board, color)
    super(pos, board, color)
  end
end

class King < SteppingPiece
  DIRECTIONS = [[1,0], [0,-1], [-1,0], [0,1], [1,1], [1,-1], [-1,1], [-1,-1]]
  REPRESENTATION = " K "

  def initialize(pos, board, color)
    super(pos, board, color)
  end
end

class Piece
  attr_reader :pos, :board

  def initialize(pos, board)
    @pos = pos
    @board = board
  end

  def self.add_direction(pos, direction)
    [pos[0] + direction[0], pos[1] + direction[1]]
  end
end

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

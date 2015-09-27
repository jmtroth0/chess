require_relative 'piece'

class SlidingPiece < Piece
  def moves
    moves = []

    self.class::DELTAS.each do |delta|
      move = Piece.add_delta(pos, delta)
      while board.empty_square?(move)
        moves << move
        move = Piece.add_delta(move, delta)
      end

      moves << move if board.piece_at?(move) && board.color_at(move) != color
    end

    moves
  end
end

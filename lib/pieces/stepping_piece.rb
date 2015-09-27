require_relative 'piece'

class SteppingPiece < Piece
  def moves
    moves = []

    self.class::DELTAS.each do |delta|
      move = Piece.add_delta(pos, delta)
      if board.on_board?(move)
        moves << move if !board.piece_at?(move) || board.color_at(move) != color
      end
    end

    moves
  end
end

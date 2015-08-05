class ComputerPlayer
  attr_reader :board, :color

  def initialize(board, color)
    @board, @color = board, color
  end

  def play_turn
    #sleep(0.5)
    moves = board.possible_moves(color)
    taking_moves = moves.select { |move| move_takes?(move) }
    board.move(*(taking_moves.empty? ? moves.sample : taking_moves.sample))
  end

  def move_takes?(move)
    start_pos, end_pos = move
    board.piece_at?(end_pos)
  end
end

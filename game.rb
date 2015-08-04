require_relative 'board'
require_relative 'human_player'

class Game
  attr_reader :board, :current_player, :other_player

  def initialize
    @board = Board.setup_board
    @current_player = HumanPlayer.new(board, :white)
    @other_player = HumanPlayer.new(board, :black)
  end

  def switch_players
    @current_player, @other_player = other_player, current_player
  end

  def play
    until winner
      board.render
      current_player.play_turn
      switch_players
    end

    puts "#{winner.to_s.capitalize} wins!"
  end

  def winner
    if board.check_mate?(:black)
      :white
    elsif board.check_mate?(:white)
      :black
    else
      nil
    end
  end
end

if __FILE__ == $PROGRAM_NAME
  Game.new.play
end

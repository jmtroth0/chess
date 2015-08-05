require_relative 'board'
require_relative 'human_player'
require_relative 'chess_error'

class Game
  attr_reader :board, :current_player, :other_player

  def initialize
    @board = Board.setup_new_board
    @current_player = HumanPlayer.new(board, :white)
    @other_player = HumanPlayer.new(board, :black)
  end

  def play
    until winner
      board.render
      if board.in_check?(current_player.color)
        puts "#{current_player.color.to_s.capitalize} is in check!"
      end
      current_player.play_turn
      switch_players
    end

    puts "#{winner.to_s.capitalize} wins!"
  end

  private

  def winner
    if board.check_mate?(:black)
      :white
    elsif board.check_mate?(:white)
      :black
    else
      nil
    end
  end

  def switch_players
    @current_player, @other_player = other_player, current_player
  end
end

if __FILE__ == $PROGRAM_NAME
  Game.new.play
end

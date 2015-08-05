require_relative 'board'
require_relative 'human_player'
require_relative 'computer_player'
require_relative 'chess_error'

class Game
  attr_reader :board, :current_player, :other_player
  attr_accessor :turns_played
  def initialize
    @board = Board.setup_new_board
    @current_player = SmartComputerPlayer.new(board, :white, 2)
    @other_player = StupidComputerPlayer.new(board, :black)
    @turns_played = 0
  end

  def play
    until winner || draw?
      board.render
      puts "Turns played: #{turns_played}"
      puts "Your turn, #{current_player.color.to_s.capitalize}."
      self.turns_played += 1
      if board.in_check?(current_player.color)
        puts "#{current_player.color.to_s.capitalize} is in check!"
      end
      current_player.play_turn
      switch_players
    end

    board.render
    puts winner ? "#{winner.to_s.capitalize} wins!" : "Draw!"
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

  def draw?
    board.draw?(current_player.color)
  end

  def switch_players
    @current_player, @other_player = other_player, current_player
  end
end

if __FILE__ == $PROGRAM_NAME
  Game.new.play
end

require './lib/requirements.rb'
require 'byebug'

class Game
  attr_reader :board, :current_player, :other_player
  attr_accessor :turns_played
  def initialize(cleverness = 2, human_player = false)
    @board = Board.setup_new_board
    if human_player
      @current_player = HumanPlayer.new(board, :white)
    else
      @current_player = StupidComputerPlayer.new(board, :white)
    end
    @other_player = SmartComputerPlayer.new(board, :black, cleverness)
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
  puts 'Would you like to play against the computer? (y/n)'
  human_player = gets.chomp == 'y'
  puts 'How clever would you like the computer to be? (natural number)'
  puts 'Be warned, any more than 3 requires fairly significant processing power'
  puts 'to respond in a reasonable amount of time'
  cleverness = gets.chomp.to_i
  Game.new(cleverness, human_player).play
end

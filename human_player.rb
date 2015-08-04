class HumanPlayer
  attr_reader :board, :color

  def initialize(board, color)
    @board, @color = board, color
  end

  def play_turn
    puts "Your turn, #{color.to_s.capitalize}."

    begin
      puts "Please use the format a1 b2"
      start_pos, end_pos = parse(gets.chomp)
      board.move(start_pos, end_pos)
    rescue InvalidMove => e
      puts e.message
      retry
    rescue
      puts "Try again"
      retry
    end
  end

  def translate(pos_input)
    col_string, row_string = pos_input.split("")

    [(row_string.to_i - 1), col_string.downcase.ord - "a".ord]
  end

  def parse(string_input)
    string_input.split.map { |pos| translate(pos) }
  end
end

class Board
  BOARD_SIZE = 8

  def initialize
    @grid = Array.new(BOARD_SIZE) { Array.new(BOARD_SIZE) }
  end

  def [](pos)
    @grid[pos[0]][pos[1]]
  end

  def empty?(pos)
    self[pos].nil?
  end

  def on_board?(pos)
    pos.all? { |coord| coord.between?(0, BOARD_SIZE - 1) }
  end
end

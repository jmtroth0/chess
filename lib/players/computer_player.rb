class SmartComputerPlayer
  attr_reader :board, :color, :cleverness

  def initialize(board, color, cleverness)
    @board, @color, @cleverness = board, color, cleverness
  end

  def play_turn
    start = Time.now
    puts "Computer is thinking..."
    board.move(*find_best_move)
    puts "Computer thought for #{Time.now - start} seconds."
  end

  private

  def tree(max_turns)
    game_states = []

    root = GameStateNode.new(board, color, max_turns)
    current_node = root

    until current_node.turns_left == 0
      current_node.create_children
      current_node.children.each { |child| game_states << child }
      current_node = game_states.shift
    end

    root
  end

  def find_best_move
    tree = tree(cleverness)
    points_for_moves = Hash.new { |h, k| h[k] = [] }

    tree.children.each do |child|
      child_points = child.best_points
      points_for_moves[child_points] << child.prev_move
    end

    best_points = points_for_moves.keys.sort.first
    points_for_moves[best_points].sample
  end
end


class GameStateNode
  attr_reader  :board, :turns_left, :player_color, :children,
               :other_color, :prev_move, :parent

  def initialize(board, player_color, turns_left, parent = nil, prev_move = nil)
    @board, @turns_left, @prev_move = board, turns_left, prev_move
    @player_color = player_color
    @other_color = player_color == :black ? :white : :black
    @parent, @children = parent, []
  end

  def create_children
    board.possible_moves(player_color).each do |move|
      new_board = board.dup
      new_board.move(*move)
      children << GameStateNode.new(new_board, other_color,
                                    turns_left - 1, self, move)
    end
  end

  def best_points
    multiplier = (turns_left + 1)**2
    loss = board.point_change_for_color(player_color, parent.board) * multiplier

    return loss if turns_left == 0
    return -1000 if board.check_mate?(player_color)
    return -15 if board.in_check?(player_color)
    return 10 if board.draw?(player_color)

    best_points_from_child = nil
    children.each do |child|
      child_points = child.best_points
      if best_points_from_child.nil? || child_points < best_points_from_child
        best_points_from_child = child_points
      end
    end

    loss - best_points_from_child
  end
end

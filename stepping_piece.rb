require_relative 'piece'

class SteppingPiece < Piece

end

class Knight < SteppingPiece

  def initialize(pos, board)
    super(pos, board)
    @directions = [[-2,1], [-1,2], [1,2], [2,1], [2,-1], [1,-2], [-1,-2], [-2,-1]]
  end

  def to_s
    inspect
  end

  def inspect
    " N "
  end
end

class King < SteppingPiece

  def initialize(pos, board)
    super(pos, board)
    @directions = [[1,0], [0,-1], [-1,0], [0,1], [1,1], [1,-1], [-1,1], [-1,-1]]
  end

  def to_s
    inspect
  end

  def inspect
    " K "
  end
end

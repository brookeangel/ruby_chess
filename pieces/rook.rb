class Rook < Piece
  MOVE_DIFFS = [
    [1, 0],
    [0, 1],
    [0, -1],
    [-1, 0],
  ]

  include Slideable

  def to_s
    " \u265C ".colorize(color)
  end

  def move_diffs
    MOVE_DIFFS
  end
end

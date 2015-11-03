class Queen < Piece
  MOVE_DIFFS = [
    [1, 1],
    [1, 0],
    [1, -1],
    [0, 1],
    [0, -1],
    [-1, 1],
    [-1, 0],
    [-1, -1]
  ]

  include Slideable

  def to_s
    " \u265B ".colorize(color)
  end

  def move_diffs
    MOVE_DIFFS
  end
end

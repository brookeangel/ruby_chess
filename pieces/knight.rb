class Knight < Piece
  MOVE_DIFFS = [
    [1, 2],
    [1, -2],
    [-1, 2],
    [-1, -2],
    [2, 1],
    [2, -1],
    [-2, 1],
    [-2, -1]
  ]

  include Steppable

  def to_s
    " \u265E ".colorize(color)
  end

  def move_diffs
    MOVE_DIFFS
  end
end

class King < Piece
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

  include Steppable

  def to_s
    " \u265A ".colorize(color)
  end

  def move_diffs
    MOVE_DIFFS
  end
end

class Pawn < Piece
  def to_s
    " \u265F ".colorize(color)
  end

  def moves
    forward_moves + side_attacks
  end

  private

  def at_start_row?
    pos[0] == ((color == :white) ? 6 : 1)
  end

  def forward_moves
    y_diff = color == :white ? -1 : 1
    one_step = [pos[0] + y_diff, pos[1]]
    return [] unless board.on_board?(*one_step)

    moves = [one_step]
    moves << [pos[0] + y_diff * 2, pos[1]] if at_start_row?

    moves
  end

  def side_attacks
    y_diff = color == :white ? -1 : 1
    diagonals = [
      [pos[0] + y_diff, pos[1] - 1],
      [pos[0] + y_diff, pos[1] + 1]
    ]

    diagonals.select do |diag|
      board.on_board?(*diag) && !board[*diag].empty?
    end
  end
end

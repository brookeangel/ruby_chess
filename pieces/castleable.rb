module Castleable

  def castle_moves
    king_moves.select { |move| valid_castle?(move) }
  end

  def valid_castle?(move)
    !moved? && squares_empty?(pos) && rook_not_moved?(move)
  end

  private

  def rook_not_moved?(move)
    rook = move[1] < 3 ? board[back_row_idx, 0] : board[back_row_idx, 7]
    !rook.moved?
  end

  def rook_move
    pos == [7, 0] ? [[back_row_idx, 2]] : [[back_row_idx, 5]]
  end

  def king_moves
    [[back_row_idx, 1], [back_row_idx, 6]]
  end

  def back_row_idx
    color == :white ? 7 : 0
  end

  def squares_empty?(pos)
    cols = pos[1] < 3 ? [1,2] : [5,6]
    cols.all? do |col_idx|
      board[back_row_idx, col_idx].empty?
    end
  end

end

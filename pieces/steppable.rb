require 'byebug'
module Steppable
  def moves
    move_diffs.map do |dir|
      prev_x, prev_y = pos
      [prev_x + dir[0], prev_y + dir[1]]
    end.select do |new_pos|
      board.on_board?(*new_pos) && board[*new_pos].color != color
    end
  end

  def move_diffs
  end
end

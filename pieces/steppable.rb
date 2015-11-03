require 'byebug'
module Steppable
  def moves
    debugger
    move_diffs.map do |dir|
      prev_x, prev_y = pos
      [prev_x + dir[0], prev_y + dir[1]]
    end.select { |new_pos| board.on_board?(*new_pos) }
  end

  def move_diffs
  end
end

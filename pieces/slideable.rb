module Slideable
  def moves
    moves = []

    move_diffs.each do |dir|
      moves.concat(moves_in_direction(*dir))
    end

    moves
  end

  def moves_in_direction(x_diff, y_diff)
    moves_in_direction = []
    current_x = pos[0] + x_diff
    current_y = pos[1] + y_diff

    while board.on_board?(current_x, current_y)

      if board[current_x, current_y].empty?
        moves_in_direction << [current_x, current_y]
        current_x += x_diff
        current_y += y_dif
      else
        moves_in_direction << [current_x, current_y] if board[current_x, current_y] != self.color
        break
      end
    end

    moves_in_direction
  end

  def move_diffs
  end

end

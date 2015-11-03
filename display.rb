require 'colorize'

class Display
  attr_reader :board, :game
  attr_accessor :active_square

  def initialize(board, game)
    @board = board
    @game = game
    @active_square = [0, 0]
  end

  def cursor=(cursor)
    @cursor = cursor
  end

  def render
    system('clear')
    puts "#{game.current_player.color}'s turn!"
    puts
    board.grid.each_with_index do |row, row_idx|
      row.each_with_index do |col, col_idx|
        print col.to_s.colorize(bg_color(row_idx, col_idx))
      end
      puts
    end

    nil
  end

  def bg_color(row_idx, col_idx)
    if [row_idx, col_idx] == active_square
      {background: :light_magenta}
    elsif (row_idx + col_idx) % 2 == 0
      {background: :light_blue}
    else
      {background: :light_yellow}
    end
  end

  def inspect
  end
end

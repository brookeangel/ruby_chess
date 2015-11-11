require 'colorize'
require_relative 'cursor'

class Display
  attr_reader :board, :game, :pos
  attr_accessor :selected, :messages

  include Cursorable

  def initialize(board, game)
    @board = board
    @game = game
    @pos = [0, 0]
    @selected = nil
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
    puts "#{board.messages.join(", ")}"

    nil
  end

  def bg_color(row_idx, col_idx)
    if [row_idx, col_idx] == pos
      {background: :light_black}
    elsif [row_idx, col_idx] == selected
      {background: :light_blue}
    elsif (row_idx + col_idx) % 2 == 0
      {background: :light_white}
    else
      {background: :light_yellow}
    end
  end

  def inspect
  end
end

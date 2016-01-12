require 'byebug'

class Piece
  attr_accessor :pos
  attr_reader :color, :board

  def initialize(pos, board, color = nil)
    @pos, @board, @color, @moved = pos, board, color, false
  end

  def empty?
    false
  end

  def moved?
    @moved
  end

  def valid_moves
    moves.reject { |to_pos| move_into_check?(to_pos) }
  end

  private

  def move_into_check?(to_pos)
    new_board = board.dup
    new_board.move!(pos, to_pos)
    new_board.in_check?(color)
  end
end

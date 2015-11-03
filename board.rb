require 'byebug'

class Board
  attr_reader :grid, :sentinel

  def initialize(fill_board = true)
    @sentinel = NullPiece.instance
    @grid = Array.new(8) do |row_idx|
      Array.new(8) { |col_idx| sentinel }
    end

    setup_pieces if fill_board
  end


  def move(start, fin)
    if valid_move?(start, fin)
      self[*fin] = self[*start]
      self[*fin].pos = fin
      self[*start] = sentinel
    else
      false
    end
  end

  def move!(start, fin)
    self[*fin] = self[*start]
    self[*fin].pos = fin
    self[*start] = sentinel
  end

  def [](x, y)
    grid[x][y]
  end

  def []=(x, y, val)
    @grid[x][y] = val
  end

  def inspect
  end

  def on_board?(x, y)
    [x, y].all? { |coord| coord.between?(0, 7) }
  end


  private

  attr_writer :grid

  def in_check?(color)
    king_pos = find_king(color).pos

    pieces.any? { |piece| piece.color != color && piece.moves.include?(king_pos) }
  end

  def checkmate?(color)
    return false unless in_check?(color)

    pieces.select { |piece| piece.color == color }.all? do |piece|
      piece.valid_moves.empty?
    end
  end

  def dup
    new_board = Board.new(false)
    pieces.each { |piece| Piece.new(piece.pos, new_board, piece.color)}
  end

  def pieces
    @rows.flatten.reject { |piece| piece.empty? }
  end

  def find_king(color)
    pieces.each do |piece|
      return piece if piece.is_a?(King) && piece.color == color
    end
  end

  def setup_pieces
    [:white, :black].each do |color|
      fill_back_row(color)
      fill_pawn_row(color)
    end
  end

  def fill_back_row(color)
    back_pieces = [
      Rook, Knight, Bishop, Queen, King, Bishop, Knight, Rook
    ]

    row_idx = (color == :white) ? 7 : 0
    back_pieces.each_with_index do |piece_class, col_idx|
      self[row_idx, col_idx] = piece_class.new([row_idx, col_idx], self, color)
    end
  end

  def fill_pawn_row(color)
    row_idx = (color == :white) ? 6 : 1
    8.times do |col_idx|
      self[row_idx, col_idx] = Pawn.new([row_idx, col_idx], self, color)
    end
  end


  def valid_move?(start, finish)
    self[*start].moves.include?(finish)
  end

end

class MoveError < StandardError
end

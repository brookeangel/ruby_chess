require 'byebug'
require_relative 'modules/board_setup.rb'
require_relative 'modules/board_castle.rb'
require_relative 'modules/pawn_upgrade.rb'

class Board
  attr_reader :grid, :sentinel, :messages

  include BoardSetupable
  include BoardCastleable
  include PawnUpgradeable

  def initialize(fill_board = true)
    @sentinel = NullPiece.instance
    @grid = Array.new(8) do |row_idx|
      Array.new(8) { |col_idx| sentinel }
    end
    @messages = []
    setup_pieces if fill_board
  end

  def move(start, fin)
    if valid_move?(start, fin)
      @messages = []
      move!(start, fin)
    else
      messages << "Invalid move."
      false
    end
  end


  def move!(start, fin)
    castle(fin) if castle?(start, fin)

    self[*fin] = self[*start]
    self[*fin].pos = fin
    self[*start] = sentinel
  end

  def clear_messages
    @messages = []
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

  def no_moves?(color)
    no_moves = pieces.select { |piece| piece.color == color }.all? do |piece|
      piece.valid_moves.empty?
    end

    if no_moves
      messages << "Stalemate."
      true
    else
      false
    end
  end


  def dup
    new_board = Board.new(false)
    pieces.each do |piece|
      new_piece = piece.class.new(piece.pos, new_board, piece.color)
      new_board[*piece.pos] = new_piece
    end
    new_board
  end

  def in_check?(color)
    king_pos = find_king(color).pos

    check = pieces.any? { |piece| piece.color != color && piece.moves.include?(king_pos) }

    if check
      messages << "#{color} is in check!"
      true
    else
      false
    end

  end

  def checkmate?(color)
    return false unless in_check?(color)

    if no_moves?(color)
      messages << "#{color} is checkmated!"
      true
    else
      false
    end
  end

  private

  attr_writer :grid

  def pieces
    grid.flatten.reject { |piece| piece.empty? }
  end

  def find_king(color)
    pieces.each do |piece|
      return piece if piece.is_a?(King) && piece.color == color
    end

    nil
  end

  def valid_move?(start, finish)
    self[*start].valid_moves.include?(finish)
  end
end

class MoveError < StandardError
end

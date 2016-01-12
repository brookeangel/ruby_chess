module BoardSetupable
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
end

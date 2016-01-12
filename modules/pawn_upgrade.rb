require 'byebug'
module PawnUpgradeable
  UPGRADABLE_PIECES = %w(Queen Rook Knight Bishop)

  def upgradeable_pawn
    (grid[0] + grid[7]).each do |piece|
      return piece if piece.is_a?(Pawn)
    end

    nil
  end

  def pawn_upgrade_prompt
    @messages = ["Pawn upgradeable! What piece would you like to exchange for?"]
  end

  def get_pawn_upgrade
    piece = gets.chomp.capitalize

    if UPGRADABLE_PIECES.include?(piece)
      upgrade_pawn(piece)
    else
      false
    end
  end

  def upgrade_pawn(piece)
    pawn = upgradeable_pawn
    self[*pawn.pos] = Module.const_get(piece).new(pawn.pos, self, pawn.color, true)
    true
  end
end

require 'singleton'

class NullPiece
  include Singleton

  def color
    nil
  end
  
  def valid_moves
    []
  end

  def empty?
    true
  end

  def to_s
    "   "
  end
end

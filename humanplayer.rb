class Player
  attr_reader :name
  attr_accessor :color, :board

  def initialize(name)
    @name = name
  end
end

class HumanPlayer < Player
  attr_accessor :cursor

  def get_move
    from_pos = get_from_position
    to_pos = get_to_position

    [from_pos, to_pos]
  end

  def get_from_position
    pos = cursor.get_move

    until board[*pos].color == self.color
      pos = cursor.get_move
    end

    pos
  end

  def get_to_position
    cursor.get_move
  end
end

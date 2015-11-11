class Player
  attr_reader :name
  attr_accessor :color, :board

  def initialize(name)
    @name = name
  end
end

class HumanPlayer < Player
  attr_accessor :display

  def get_move
    from_pos = get_from_position
    display.selected = from_pos

    to_pos = get_to_position

    display.selected = nil
    [from_pos, to_pos]
  end

  def get_from_position
    pos = display.get_move

    until board[*pos].color == self.color
      pos = display.get_move
    end

    pos
  end

  def get_to_position
    display.get_move
  end
end

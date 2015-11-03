require 'io/console'

class Cursor
  attr_accessor :pos
  attr_reader :display

  def initialize(display)
    @pos = [0, 0]
    @display = display
    display.cursor = self
  end

  def get_move
    input = nil

    until input == :select
      input = get_user_input

      if arrow_key?(input)
        update_cursor(input)
        display.active_square = pos
      end

      system('clear')
      display.render
    end

    pos.dup
  end

  private

  def read_char
    STDIN.echo = false
    STDIN.raw!

    input = STDIN.getc.chr
    if input == "\e" then
      input << STDIN.read_nonblock(3) rescue nil
      input << STDIN.read_nonblock(2) rescue nil
    end

  ensure
    STDIN.echo = true
    STDIN.cooked!

    return input
  end

  def get_user_input
    c = nil

    until c
      c = read_char

      case c
      when "\r"
        return :select
      when " "
        return :space
      when "s"
        return :save
      when "\e[A"
        return :up
      when "\e[B"
        return :down
      when "\e[C"
        return :right
      when "\e[D"
        return :left
      when "\u0003"
        puts "Exit"
        exit 0
      end
    end
  end

  def arrow_key?(input)
    [:up, :down, :right, :left].include?(input)
  end

  def update_cursor(direction)
    board = display.board.grid

    case direction
    when :down
      pos[0] = (pos[0] + 1) % board.size
    when :up
      pos[0] = (pos[0] - 1) % board.size
    when :right
      pos[1] = (pos[1] + 1) % board.size
    when :left
      pos[1] = (pos[1] - 1) % board.size
    end
  end


end

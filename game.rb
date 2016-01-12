require_relative 'pieces'
require_relative 'display'
require_relative 'board'
require_relative 'cursor'
require_relative 'humanplayer'

class Chess
  attr_reader :players

  def initialize(player1, player2)
    @board = Board.new
    @display = Display.new(board, self)
    @players = [player1, player2]

    setup_players
  end

  def play
    welcome_message

    until over?
      display.render
      move = players.first.get_move

      if make_move(move)
        pawn_upgrade_loop if board.upgradeable_pawn
        players.rotate!
        clear_messages
      end
    end
  end

  def current_player
    players.first
  end

  private

  attr_reader :board, :display

  def clear_messages
    board.clear_messages
  end

  def make_move(move)
    from_pos, to_pos = move[0], move[1]
    board.move(from_pos, to_pos)
  end

  def pawn_upgrade_loop
    loop do
      board.pawn_upgrade_prompt
      display.render
      break if board.get_pawn_upgrade
    end
  end

  def over?
    board.no_moves?(players.first.color) ||
      [:black, :white].any? { |color| board.checkmate?(color) }
  end

  def welcome_message
    system('clear')
    puts "Welcome to Chess!"
    sleep(1)
    system('clear')
  end

  def setup_players
    colors = [:white, :black]
    players.each do |player|
      player.display = display
      player.board = board
      player.color = colors.shift
    end
  end
end

if __FILE__ == $PROGRAM_NAME
  player1 = HumanPlayer.new('Brooke')
  player2 = HumanPlayer.new('Max')
  Chess.new(player1, player2).play
end

require_relative "board"

class Game
  attr_reader :board, :current_player

  def initialize(size = 3)
    @board = Board.new(size)
    @current_player = '1'
  end
  
  def switch_player
    @current_player = @current_player == '1' ? '2' : '1'
  end
  
  def valid_input?(input)
    input = input.upcase
    return true if input.match?(/^RR$/) || input.match?(/^XX$/)
    
    last_row = (64 + board.size).chr
    last_col = board.size.to_s

    input.match?(/^[A-#{last_row}][1-#{last_col}]$/)
  end
end

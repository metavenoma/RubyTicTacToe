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

  def restart_game
    @board = Board.new(board.size)
    @current_player = '1'
  end

  def parse_input(input)
    row = input[0].upcase.ord - 'A'.ord
    col = input[1].to_i - 1
    [row, col]
  end

  def play
    loop do
      board.print_grid
      puts "Player #{@current_player}, enter your move."
      
      input = gets.chomp
      if valid_input?(input)
        case input.upcase
        when "XX"
          puts "exit game"
          break
        when "RR"
          puts "game restart"
          restart_game
          next
        else
          row, col = parse_input(input)
          if board.place_move(row, col, @current_player)
            if board.winner?
              board.print_grid
              puts "Player #{@current_player} wins!"
              break
            elsif board.draw?
              board.print_grid
              puts "draw"
              break
            end
            switch_player
          else
            puts "Invalid move."
          end
        end
      else
        puts "Invalid input"
      end
    end
  end
end

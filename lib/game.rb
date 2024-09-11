require_relative "board"
require_relative "print_ascii"

class Game
  attr_reader :board, :current_player

  def initialize
    @current_player = '1'
  end
  
  def switch_player
    @current_player = @current_player == '1' ? '2' : '1'
  end
  
  def valid_input?(input)
    input = input.upcase
    return true if input.match?(/^RR$/) || input.match?(/^XX$/)
    
    last_row = (64 + board.size).chr
    last_col = board.size.to_i

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
    print_header
    board_size = nil
    
    loop do
      puts "Enter the size of the board (3-9):"
      input = gets.chomp
      
      begin
        board_size = Integer(input)
        if board_size.between?(3, 9)
          break
        else
          puts "Invalid size. Please enter a number between 3 and 9."
        end
      rescue ArgumentError
        puts "Invalid input. Please enter a valid number."
      end
    end
    
    @board = Board.new(board_size)

    loop do
      board.print_grid
      puts "Player #{@current_player}, enter your move."
      
      input = gets.chomp
      if valid_input?(input)
        case input.upcase
        when "XX"
          print_goodbye
          break
        when "RR"
          print_restart
          restart_game
          next
        else
          row, col = parse_input(input)
          if board.place_move(row, col, @current_player)
            if board.winner?
              board.print_grid
              puts @current_player
              print_winner(@current_player)
              break
            elsif board.draw?
              board.print_grid
              print_winner(0)
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

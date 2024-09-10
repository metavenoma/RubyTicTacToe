class Board
  attr_reader :grid

  def initialize(size = 3)
    @size = size
    @grid = Array.new(size) { Array.new(size, ' ') }
  end

  def size
    @size
  end
  
  def place_move(row, col, player)
    return if (row >= size || col >= size)
    return if @grid[row][col] != ' '
    @grid[row][col] = player == "1" ? 'X' : 'O'
  end
 
  def draw?
    game_over = @grid.flatten.none? { |cell| cell == ' ' }
    no_winner = !winner?
    game_over && no_winner
  end

  def winner?
    lines = rows + columns + diagonals
    lines.any? { |line| line.uniq.length == 1 && line.uniq != [' '] }
  end
  
  def rows
    @grid
  end
  
  def columns
    @grid.transpose
  end
  
  def diagonals
    [
      (0...size).collect { |i| @grid[i][i] },
      (0...size).collect { |i| @grid[i][size - 1 - i] }
    ]
  end

  def print_grid
    puts "\n\t\t\t    " + (1..size).to_a.join("   ")
    puts "\t\t\t   " + ("--- " * size)

    ('A'..('A'.ord + size - 1).chr).each_with_index do |row_label, row|
      print "\t\t\t#{row_label} "
      @grid[row].each do |cell|
        print "| #{cell} "
      end
      puts "|"
      puts "\t\t\t   " + ("--- " * size)
    end
  end
end

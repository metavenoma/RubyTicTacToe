class Board
  attr_reader :grid

  def initialize(size)
    @size = size
    @grid = Array.new(size) { Array.new(size, ' ') }
  end

  def size
    @size
  end
  
  def place_move(row, col, player)
    raise 'Position not available.' if @grid[row][col] != ' '
    @grid[row][col] = (player == 1 ? 'X' : 'O')
  end
  
  def winner?
    rows_winner? || columns_winner? || diagonals_winner?
  end
  
  def rows_winner?
    @grid.any? { |row| row.uniq.size == 1 && row.first != ' ' }
  end
  
  def columns_winner?
    @grid.transpose.any? { |col| col.uniq.size == 1 && col.first != ' ' }
  end
  
  def diagonals_winner?
    forwards_diagonal = [@grid[0][0], @grid[1][1], @grid[2][2]]
    backwards_diagonal = [@grid[0][2], @grid[1][1], @grid[2][0]]
    [forwards_diagonal, backwards_diagonal].any? { |diag| diag.uniq.size == 1 && diag.first != ' ' }
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

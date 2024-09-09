class Board
  attr_reader :grid

  def initialize(size)
    @size = size
    @grid = Array.new(size) { Array.new(size, ' ') }
  end

  def size
    @size
  end

  def print_grid
    puts "\n\t\t\t    " + (1..size).to_a.join("   ")
    puts "\t\t\t   " + ('--- ' * size)

    ('A'..('A'.ord + size - 1).chr).each_with_index do |row_label, row|
      print "\t\t\t#{row_label} "
      @grid[row].each do |cell|
        print "| #{cell} "
      end
      puts "|"
      puts "\t\t\t   " + ('--- ' * size)
    end
  end
end

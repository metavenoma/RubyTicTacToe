require_relative '../lib/board'

RSpec.describe Board do
  before do
    @board = Board.new(3)
  end
  
  describe '#initialize' do
    it 'creates an empty board of the specified size' do
      expected_grid = Array.new(@board.size) { Array.new(@board.size, " ") }
      expect(@board.grid).to eq(expected_grid)
    end
  end
end

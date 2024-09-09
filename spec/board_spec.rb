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

  describe '#place_move' do
    it 'places player move on the board' do
      @board.place_move(1, 1, 1)
      expect(@board.grid[1][1]).to eq('X')
    end

    it 'returns an error when the position is not available' do
      @board.place_move(0, 0, 1)
      expect { @board.place_move(0, 0, 2) }.to raise_error('Position not available.')
    end
  end

  describe '#winner?' do
    it 'returns true if there is a winning row' do
      @board.place_move(0, 0, 1)
      @board.place_move(0, 1, 1)
      @board.place_move(0, 2, 1)
      expect(@board.rows_winner?).to eq(true)
      expect(@board.winner?).to eq(true) 
    end

    it 'returns true if there is a winning column' do
      @board.place_move(0, 0, 1)
      @board.place_move(1, 0, 1)
      @board.place_move(2, 0, 1)
      expect(@board.columns_winner?).to eq(true)
      expect(@board.winner?).to eq(true)
    end

    it 'returns true if there is a winning diagonal' do
      @board.place_move(0, 0, 1)
      @board.place_move(1, 1, 1)
      @board.place_move(2, 2, 1)
      expect(@board.diagonals_winner?).to eq(true)
      expect(@board.winner?).to eq(true)
    end
  end
end

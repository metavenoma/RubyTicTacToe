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
      expect(@board.winner?).to eq(true) 
    end

    it 'returns true if there is a winning column' do
      @board.place_move(0, 0, 1)
      @board.place_move(1, 0, 1)
      @board.place_move(2, 0, 1)
      expect(@board.winner?).to eq(true)
    end

    it 'returns true if there is a winning diagonal' do
      @board.place_move(0, 0, 1)
      @board.place_move(1, 1, 1)
      @board.place_move(2, 2, 1)
      expect(@board.winner?).to eq(true)
    end
  end
  
  describe '#draw?' do
    it 'returns true if the game is over and is a draw' do
      draw_example = [
        ['X', 'O', 'X'],
        ['O', 'X', 'X'],
        ['O', 'X', 'O'],
      ]

      @board.instance_variable_set(:@grid, draw_example)
      expect(@board.draw?).to eq(true)
    end

    it 'returns false if the board is not full' do
      not_full_grid = [
        ['X', 'X', 'O'],
        [' ', 'X', 'O'],
        ['O', 'O', 'X'],
      ]

      @board.instance_variable_set(:@grid, not_full_grid)
      expect(@board.draw?).to eq(false)
    end

    it 'returns false if the board is full but there is a winner' do
      full_grid_with_winner = [
        ['X', 'O', 'X'],
        ['X', 'O', 'X'],
        ['O', 'O', 'O'],
      ]

      @board.instance_variable_set(:@grid, full_grid_with_winner)
      expect(@board.draw?).to eq(false)
    end
  end
end

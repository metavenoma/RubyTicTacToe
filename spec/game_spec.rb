require_relative "../lib/game"
require_relative "../lib/board"

RSpec.describe Game do
  before do
    @game = Game.new
  end

  describe "#initialize" do
    it "initializes with an empty grid and sets player to 1" do
      expect(@game.board.grid).to eq([[" ", " ", " "], [" ", " ", " "], [" ", " ", " "]])
      expect(@game.current_player).to eq('1')
    end
  end

  describe "#switch_player" do
    it "switches current player from 1 to 2" do
      @game.switch_player
      expect(@game.current_player).to eq('2')
    end

    it "switches current player back from 2 to 1" do
      @game.switch_player
      @game.switch_player
      expect(@game.current_player).to eq('1')
    end
  end

  describe "#valid_input?" do
    it "returns true for valid inputs" do
      expect(@game.valid_input?("A1")).to eq(true)
      expect(@game.valid_input?("a1")).to eq(true)
      expect(@game.valid_input?("c3")).to eq(true)
      expect(@game.valid_input?("xx")).to eq(true)
    end

    it "returns false for invalid inputs" do
      expect(@game.valid_input?("1 1")).to eq(false)
      expect(@game.valid_input?("a 2")).to eq(false)
      expect(@game.valid_input?("return")).to eq(false)
      expect(@game.valid_input?("2")).to eq(false)
    end
  end
end

                                     

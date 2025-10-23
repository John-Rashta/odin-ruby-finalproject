require_relative "../lib/board"

describe Board do
  subject(:basic_board) { described_class.new }
  describe "#initialize" do
    it "has 8 rows" do
      current_rows = basic_board.board.length
      expect(current_rows).to eq(8)
    end

    it "has 8 columns" do
      current_columns = basic_board.board[0].length
      expect(current_columns).to eq(8)
    end
  end

  describe "#validate_location?" do
    it "returns true when valid" do
      valid_move = basic_board.validate_location?([0, 0])
      expect(valid_move).to eq(true)
    end

    it "returns false when invalid" do
      invalid_move = basic_board.validate_location?([0, 10])
      expect(invalid_move).to eq(false)
    end

    it "returns false when invalid 2" do
      invalid_move = basic_board.validate_location?([10, 0])
      expect(invalid_move).to eq(false)
    end
  end

  describe "#board" do
    it "returns the full board" do
      full_board = basic_board.board
      expect(full_board).to eq(Array.new(8) { Array.new(8) })
    end

    xit "returns board after a move" do
    end
  end

  describe "#clear_board" do
    context "clears board correctly" do
      xit "clears the board" do
        basic_board.make_move(1, 5)
        basic_board.clear_board
        expected_place = basic_board.instance_variable_get(:@my_board)[0][1]
        expect(expected_place.strip).to be_nil
      end
    end
  end
end

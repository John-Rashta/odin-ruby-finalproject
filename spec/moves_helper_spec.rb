require_relative "../lib/moves_helper"

RSpec.shared_examples "move validation" do |final_val, move_methods|
  move_methods.each do |move_method|
    it "should return #{final_val}" do
      move_to_validate = moves_checker.send(*move_method)
      expect(move_to_validate).to eq(final_val)
    end
  end
end

describe MovesHelper do
  subject(:moves_checker) { Class.new { extend MovesHelper } }
  describe "#validate_rook?" do
    method_symbol = :validate_rook?
    it_should_behave_like "move validation", false, [[method_symbol, [0, 0], [1, 1]]]
    it_should_behave_like "move validation", true, [
      [method_symbol, [0, 0], [0, 5]],
      [method_symbol, [0, 0], [5, 0]]
    ]
  end

  describe "#validate_bishop?" do
    method_symbol = :validate_bishop?
    it_should_behave_like "move validation", false, [[method_symbol, [0, 0], [0, 3]]]
    it_should_behave_like "move validation", true, [
      [method_symbol, [5, 5], [7, 3]],
      [method_symbol, [5, 5], [3, 3]],
      [method_symbol, [5, 5], [7, 7]],
      [method_symbol, [5, 5], [3, 7]]
    ]
  end

  describe "#validate_queen?" do
    method_symbol = :validate_queen?
    it_should_behave_like "move validation", false, [[method_symbol, [5, 5], [6, 7]]]
    it_should_behave_like "move validation", true, [
      [method_symbol, [5, 5], [5, 0]],
      [method_symbol, [5, 5], [0, 5]],
      [method_symbol, [5, 5], [7, 3]],
      [method_symbol, [5, 5], [3, 3]],
      [method_symbol, [5, 5], [7, 7]],
      [method_symbol, [5, 5], [3, 7]]
    ]
  end

  describe "#validate_king?" do
    method_symbol = :validate_king?
    it_should_behave_like "move validation", false, [[method_symbol, [5, 5], [6, 7]]]
    it_should_behave_like "move validation", true, [
      [method_symbol, [5, 5], [5, 4]],
      [method_symbol, [5, 5], [4, 5]],
      [method_symbol, [5, 5], [6, 5]],
      [method_symbol, [5, 5], [5, 6]],
      [method_symbol, [5, 5], [6, 6]],
      [method_symbol, [5, 5], [4, 4]],
      [method_symbol, [5, 5], [4, 6]],
      [method_symbol, [5, 5], [6, 4]]
    ]
  end

  describe "#validate_knight?" do
    method_symbol = :validate_knight?
    it_should_behave_like "move validation", false, [[method_symbol, [5, 5], [6, 6]]]
    it_should_behave_like "move validation", true, [
      [method_symbol, [5, 5], [6, 3]],
      [method_symbol, [5, 5], [7, 4]],
      [method_symbol, [5, 5], [7, 6]],
      [method_symbol, [5, 5], [6, 7]],
      [method_symbol, [5, 5], [4, 3]],
      [method_symbol, [5, 5], [3, 4]],
      [method_symbol, [5, 5], [4, 7]],
      [method_symbol, [5, 5], [3, 6]]
    ]
  end

  describe "#validate_pawn?" do
    method_symbol = :validate_pawn?
    it_should_behave_like "move validation", false, [[method_symbol, [5, 5], [8, 6], "white"]]
    it_should_behave_like "move validation", true, [
      [method_symbol, [5, 5], [7, 5], "black", true],
      [method_symbol, [5, 5], [6, 5], "black"],
      [method_symbol, [5, 5], [3, 5], "white", true],
      [method_symbol, [5, 5], [4, 5], "white"]
    ]
  end

  describe "#validate_pawn_take?" do
    method_symbol = :validate_pawn_take?
    it_should_behave_like "move validation", false, [[method_symbol, [5, 5], [8, 6], "white"]]
    it_should_behave_like "move validation", true, [
      [method_symbol, [5, 5], [6, 4], "black"],
      [method_symbol, [5, 5], [6, 6], "black"],
      [method_symbol, [5, 5], [4, 4], "white"],
      [method_symbol, [5, 5], [4, 6], "white"]
    ]
  end

  describe "#pawn_direction_valid?" do
    method_symbol = :pawn_direction_valid?
    it_should_behave_like "move validation", false, [
      [method_symbol, [5, 5], [8, 6], "white"],
      [method_symbol, [5, 5], [3, 6], "black"]
    ]
    it_should_behave_like "move validation", true, [
      [method_symbol, [5, 5], [3, 5], "white"],
      [method_symbol, [5, 5], [8, 5], "black"]
    ]
  end

  describe "#get_absolute" do
    it "returns the correct numbers" do
      absolutes = moves_checker.get_absolute([0, 0], [2, 3])
      expect(absolutes).to eql([2, 3])
    end
  end
end

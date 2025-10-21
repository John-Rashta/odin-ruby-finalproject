class Board
  attr_reader :rows, :columns

  def initialize
    @my_board = Array.new(8) { Array.new(8) }
    @rows = 8
    @columns = 8
  end

  def validate_location?(location)
    location[0].between?(0, rows) && location[1].between?(0, columns)
  end

  def clear_board
    @my_board.map! { |ele| ele.fill(nil) }
  end

  def board
    @my_board.map(&:itself)
  end
end

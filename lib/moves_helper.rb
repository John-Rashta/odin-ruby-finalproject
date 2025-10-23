# Module to help validate pieces moves
module MovesHelper
  def validate_pawn?(old_location, new_location, color, first_move = false) # rubocop:disable Style/OptionalBooleanParameter
    return false unless pawn_direction_valid?(old_location, new_location, color)

    column_valid = (old_location[0] - new_location[0]).abs
    (first_move && column_valid == 2) || column_valid == 1
  end

  def validate_rook?(old_location, new_location)
    old_location[0] == new_location[0] || old_location[1] == new_location[1]
  end

  def validate_bishop?(*args)
    differences = get_absolute(*args)
    differences[0] == differences[1]
  end

  def validate_queen?(*args)
    validate_rook?(*args) || validate_bishop?(*args)
  end

  def validate_king?(*args)
    differences = get_absolute(*args)
    differences.all? { |num| num.between?(0, 1) }
  end

  def validate_knight?(*args)
    differences = get_absolute(*args)
    (differences[0] == 1 && differences[1] == 2) ||
      (differences[0] == 2 && differences[1] == 1)
  end

  def validate_pawn_take?(old_location, new_location, color)
    return false unless pawn_direction_valid?(old_location, new_location, color)

    differences = get_absolute(old_location, new_location)
    differences.all? { |num| num == 1 }
  end

  def pawn_direction_valid?(old_location, new_location, color)
    case color
    when "white"
      return false if old_location[0] < new_location[0]
    when "black"
      return false if old_location[0] > new_location[0]
    end
    true
  end

  def get_absolute(old_location, new_location)
    [(old_location[0] - new_location[0]).abs, (old_location[1] - new_location[1]).abs]
  end
end

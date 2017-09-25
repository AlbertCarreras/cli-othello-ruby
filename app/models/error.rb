class InvalidInputError < StandardError
  def start_message
    "     Invalid input. Please type 'start' and press enter to being."
  end

  def move_message
    "     That move is not valid. Please try again."
  end

  def input_message
    "     Invalid input. Please type the row # followed by the column letter"
  end
end

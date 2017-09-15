class InvalidInputError < StandardError
  def start_message
    "     Invalid input. Please type 'start' and press enter to being."
  end

  def move_message
    "     That move is not valid. Please try again."
  end
end

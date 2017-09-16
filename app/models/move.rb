class Move < ActiveRecord::Base
  belongs_to :player
  belongs_to :game

  def opp_chip_up?(same_chip, opp_chip, player)
  end

  def opp_chip_down?(same_chip, opp_chip, player)
  end

  def opp_chip_left?(same_chip, opp_chip, player)
  end

  def opp_chip_right?(same_chip, opp_chip, player)
  end

  def opp_chip_up_left?(same_chip, opp_chip, player)
  end

  def opp_chip_up_right?(same_chip, opp_chip, player)
  end

  def opp_chip_down_left?(same_chip, opp_chip, player)
  end

  def opp_chip_down_right?(same_chip, opp_chip, player)
  end

  def get_chip_types(player)
    if player
      same_chip = 0
      opp_chip = 1
    elsif
      same_chip = 1
      opp_chip = 0
    end
    chips = {
      same: same_chip,
      opp: opp_chip
    }
  end


end

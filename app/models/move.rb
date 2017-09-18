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
    chips = {
      same: player.chip,
      opp: (player.chip - 1).abs
    }
  end

  def check_move(player)
    chips = get_chip_types(player)
    valid = []

    valid << self.opp_chip_up?(chips[:same], chips[:opp], player)
    valid << self.opp_chip_down?(chips[:same], chips[:opp], player)
    valid << self.opp_chip_right?(chips[:same], chips[:opp], player)
    valid << self.opp_chip_left?(chips[:same], chips[:opp], player)
    valid << self.opp_chip_up_right?(chips[:same], chips[:opp], player)
    valid << self.opp_chip_up_left?(chips[:same], chips[:opp], player)
    valid << self.opp_chip_down_right?(chips[:same], chips[:opp], player)
    valid << self.opp_chip_down_left?(chips[:same], chips[:opp], player)

    if valid.include?(true)
      return true
    end
  end



end

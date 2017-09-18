class Game < ActiveRecord::Base
  has_many :players, through: :boards

end

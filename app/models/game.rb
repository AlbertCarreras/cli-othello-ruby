class Game < ActiveRecord::Base
  has_many :players, through: :moves
  has_many :moves

end

require 'bundler'

Bundler.require

ActiveRecord::Base.establish_connection(
  adapter: 'sqlite3',
  database: 'db/development.db'
)

ActiveRecord::Base.logger = nil

require_relative '../app/models/error.rb'
require_relative '../app/models/game.rb'
require_relative '../app/models/board.rb'
require_relative '../app/models/move.rb'
require_relative '../app/models/player.rb'
require_relative '../app/models/clirunner.rb'

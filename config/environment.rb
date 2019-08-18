require 'bundler/setup'
Bundler.require

ActiveRecord::Base.establish_connection(
  :adapter => "sqlite3",
  :database => "db/#{ENV['SINATRA_ENV']}.sqlite"
)

require_all 'lib'
require_all 'app'

#------------ working before trying to get the app running ---------#

# DB = {
#   conn: SQLite3::Database.new('db/development.sqlite')
# }

# DB[:conn].results_as_hash = true

require_relative '../lib/golfer_app.rb'


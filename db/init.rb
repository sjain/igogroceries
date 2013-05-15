require 'rubygems'
require 'bundler/setup'

require 'sqlite3'
require 'active_record'
require 'rest_client'
require 'json'
require 'carmen'
require 'us_states'

ActiveRecord::Base.establish_connection(
  :adapter => 'sqlite3',
  :database =>  'database.sqlite'
)

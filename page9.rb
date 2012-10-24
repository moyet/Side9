#! /usr/local/bin/ruby

require 'net/http'
require 'uri'
require 'sqlite3'
require '~/bin/side9/side9_pige.rb'
require 'yaml'


filnavn = '/Users/magnus/.side9/side9piger.yml'
databasePlacering = '/Users/magnus/.side9/piger.db'


$piger = []
File.open( filnavn ){ |f| $piger = YAML.load(f) } if File.exists?(filnavn)

$db = SQLite3::Database.new( databasePlacering )

$piger.each do |pige|
  pige.save_in_db($db)
end

$db.execute( "select * from pige" ) do |row|
#  puts row

  end

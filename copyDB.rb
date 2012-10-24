#! /usr/local/bin/ruby
# encoding: utf-8

require 'net/http'
require 'uri'
require '~/bin/side9/side9_pige.rb'
require 'sqlite3'
require '~/bin/side9/stat.rb'

gammelDB = '/Users/magnus/.side9/piger.db'
nyDB = '/Users/magnus/.side9/pige.db'

$gammeldb = SQLite3::Database.new( gammelDB )
$nydb = SQLite3::Database.new( nyDB )

$gammeldb.execute("SELECT * from pige") do |row|
     pige = Side9Pige.new(row[1], row[2].to_i, row[3], row[4], row[5])
     pige.save_in_db($nydb)
end

#! /usr/local/bin/ruby

require 'net/http'
require 'uri'
require '~/bin/side9/side9_pige.rb'
require 'yaml'
require 'sqlite3'


page9 = 'http://ekstrabladet.dk/side9/'
#pattern = %r{<p class="gallery-txt"><strong>(.+) er (\d+) &aring;r og fra (.+).</strong> Fotograf: (.+)</p>} 
pattern = %r{<div class="default_article"><h1>(.+), (\d+) \w\w <br />og fra (.+)</h1></div> }

filnavn = '/Users/magnus/.side9/side9piger.yml'
databasePlacering = '/Users/magnus/.side9/piger.db'

$db = SQLite3::Database.new( databasePlacering )

url = URI.parse(page9);
res = Net::HTTP.get(url)
    
res.each_line do |linie| 
    if linie =~ pattern 
      pige = Side9Pige.new($1, $2, $3, $4, Date.today)
        pige.save_in_db($db)
      end  
  end


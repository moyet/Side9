#! /usr/local/bin/ruby

require 'net/http'
require 'uri'
require '~/bin/side9/side9_pige.rb'
require 'sqlite3'
require '~/bin/side9/stat.rb'

filnavn = '/Users/magnus/.side9/side9piger.yml'
databasePlacering = '/Users/magnus/.side9/piger.db'

$db = SQLite3::Database.new( databasePlacering )

def findfleste(type)
  
  puts "Liste af #{type} sorteret efter antal"
  nyHash = Hash.new
  noget = []
  
  $db.execute("SELECT #{type} from pige ;  ") do |row|
      #puts "#{row[0]}"
      noget << row[0].force_encoding("UTF-8")
      
    end
    noget.histogram.sort{|a,b| b[1]<=>a[1]}.each { |elem|
      puts "#{elem[1]}, #{elem[0]}"
    }
    
    
    
end


def findStats()
  pigerne = []
  alder = []
  foto = []
  hjemby = []
  $db.execute("SELECT * from pige") do |row|
      pige = Side9Pige.new(row[1], row[2].to_i, row[3], row[4], row[5])
      pigerne << pige
      alder << pige.age
      hjemby << pige.hometown.force_encoding("UTF-8")
      foto << pige.photografer
    end


  puts alder.mean, alder.deviation, alder.median, alder.size, alder.histogram
    #puts foto.histogram

   hjembyer = hjemby.histogram
   
   
   hjemby = []
   hjembyer.each_pair{|key, value| hjemby << "#{value}, #{key}"}
  
   hjembyer.sort{|a,b| b[1]<=>a[1]}.each { |elem|
     puts "#{elem[1]}, #{elem[0]}"
   }

   
end

findStats()
findfleste(:navn)
#findfleste(:alder)
#findfleste(:hjemby)
#findfleste(:fotograf)
#findfleste(:visningsdato)


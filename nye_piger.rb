#! /usr/local/bin/ruby

require 'net/http'
require 'uri'
require '~/bin/side9/side9_pige.rb'
require 'yaml'
require 'sqlite3'


page9 = 'http://ekstrabladet.dk/side9/'
pattern = %r{<a href="(http://ekstrabladet.dk/side9/article[0-9]{7}.ece)" onclick=".*ClickImage.*">.*<img class="nine_overlay-more"} 
#pattern = %r{<a href="(http://ekstrabladet.dk/side9/article[0-9]{7}.ece)" onclick=".*">}
#pattern = %r{<a href="(http://ekstrabladet.dk/side9/article[0-9]{7}.ece)" class="img" onclick=".*">}

    
new_pattern = %r{<h1>(.+), (\d+) .r og fra (.+)</h1>}
date_pattern = %r{\d{2}:\d{2}, (\d{2}). (jan|feb|mar|apr|maj|jun|jul|aug|sep|okt|nov|dec) (201\d)}
photo_pattern = %r{jQuery\(".img-caption:first"\).prepend\("Foto: (.*) "\);}
filnavn = '/Users/magnus/.side9/side9piger.yml'
databasePlacering = '/Users/magnus/.side9/pige.db'

def navn_til_nummer(streng)
  if streng == "jan" then return "01" end
  if streng == "feb" then return "02" end
  if streng == "mar" then return "03" end
  if streng == "apr" then return "04" end
  if streng == "maj" then return "05" end
  if streng == "jun" then return "06" end
  if streng == "jul" then return "07" end
  if streng == "aug" then return "08" end
  if streng == "sep" then return "09" end
  if streng == "okt" then return "10" end
  if streng == "nov" then return "11" end
  if streng == "dec" then return "12" end
  
end

$db = SQLite3::Database.new( databasePlacering )


url = URI.parse(page9);
res = Net::HTTP.get(url)

res.each_line do |linie| 
    if linie =~ pattern
      puts "match: #{$1}"
      
      new_url = URI.parse($1);
      new_res = Net::HTTP.get(new_url)
      
      @dato
      @photo
      
      new_res.each_line do |linie| 
        if linie =~ date_pattern
          @dato = "#{$3}-#{navn_til_nummer($2)}-#{$1}"
        end

        if linie =~ photo_pattern
          @photo = "#{$1}"
          puts @photo
        end
        
      end
      
      new_res.each_line do |linie| 

          if linie =~ new_pattern 
            pige = Side9Pige.new($1, $2, $3, '', Date.today)
            pige.day = @dato unless @dato.nil?
            pige.photografer = @photo unless @photo.nil?
            pige.save_in_db($db)
            #puts @dato
           end  
        end
     break
    end  
  end


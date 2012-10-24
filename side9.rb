#! /usr/local/bin/ruby

require 'net/http'
require 'uri'
require '~/bin/side9/side9_pige.rb'
require 'yaml'

page9 = 'http://ekstrabladet.dk/side9/'
pattern = %r{<p class="gallery-txt"><strong>(.+) er (\d+) &aring;r og fra (.+).</strong> Fotograf: (.+)</p>} 
filnavn = '/Users/magnus/.side9/side9piger.yml'

$piger = []
File.open( filnavn ){ |f| $piger = YAML.load(f) } if File.exists?(filnavn)

url = URI.parse(page9);
res = Net::HTTP.get(url)
    
res.each_line do |linie| 
    if linie =~ pattern 
      pige = Side9Pige.new($1, $2, $3, $4)
      $piger << pige 
    end  
  end

puts $piger.to_yaml


f = File.open( filnavn, 'w' ) 
  YAML.dump($piger, f ) 
f.close

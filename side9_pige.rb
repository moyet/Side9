# encoding: utf-8

require 'sqlite3'

class Side9Pige
  
 attr_accessor(:name, :age, :hometown, :photografer, :day)
 
 def initialize(name,age,hometown,photografer,day)
   @name = name
   @age = age
   @hometown = hometown
   @photografer = photografer
   @day = day
  end
  
  
  def to_s
    return "#{@name} er #{@age} aar gammel og er fra #{@hometown}, billedet blev taget af #{@photografer} og bragt #{@day}"
  end

  def save_in_db(database)
    puts self.to_s
    database.execute("insert into pige (alder,hjemby,fotograf,navn,visningsdato) values (?,?,?,?,?) " , [@age.to_i, @hometown, @photografer.strip, @name, @day.to_s])
  end
  
  def <=>(pige)
    
      return -1 if self.age.to_i < pige.age.to_i
      return -1 * (self.name <=> pige.name) if self.age.to_i == pige.age.to_i
      return 1 if self.age.to_i > pige.age.to_i
  end
  
end



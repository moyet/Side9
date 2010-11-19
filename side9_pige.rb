class Side9Pige
  
 attr_accessor(:name, :age, :hometown, :photografer, :day)
 
 def initialize(name,age,hometown,photografer)
   @name = name
   @age = age
   @hometown = hometown
   @photografer = photografer
   @day = Date.today
  end
  
  
  def to_s
    return "#{@name} er #{@age} år gammel og er fra #{@hometown}, billedet blev taget af #{@photografer} og bragt #{@day}"
  end
  
end
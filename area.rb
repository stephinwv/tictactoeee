class Area
  attr_accessor :length, :height
  def initialize(h, l)
    @height = h
    @length = l
  end
  # def speak
  #   "#{name} says arf!"
  # end
  def rectangle
   area = length * height
   "The area of a rectangle with a length of #{length} and a height of #{height} is #{area}"
  end
  def triangle
    area = (length * height) / 2
    "The area of an isoscoles triangle with a length of #{length} and a height of #{height} is #{area}"    
  end
end
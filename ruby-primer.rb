# 0.0 Introduction to Objects
1.next.next

# 0.1 More Objects and Methods
## ex. 1
1.methods.sort

## ex. 2
2.between?(1,3)

# 0.2 Syntactic Sugar for Special Methods
4.+(3)

# 1.0 Introduction to Strings
## ex. 1
"Ruby Monk"

## ex. 2
'September'

## ex. 3
"September"

## ex. 4
'RubyMonk'.length

# 1.1 String Basics
## ex. 1
def string_length_interpolater(incoming_string)
  "The string you just gave me has a length of #{incoming_string.length}"
end

## ex. 2
"[Luke:] I can’t believe it. [Yoda:] That is why you fail.".include?('Yoda')

## ex. 3
"Ruby is a beautiful language".start_with?('Ruby')

## ex. 4
"I can't work with any other language but Ruby".end_with?('Ruby')

## ex. 5
"I am a Rubyist".index('R')

## ex. 6
'This is Mixed CASE'.downcase

## ex. 7
"ThiS iS A vErY ComPlEx SenTeNcE".swapcase

# 1.2 Advanced String Operations
## ex. 1
'Fear is the path to the dark side'.split(' ')

## ex. 2
'RubyMonk Is Pretty Brilliant'.gsub(/[A-Z]/,'0')

## ex. 3
'RubyMonk Is Pretty Brilliant'.match(/ ./, 11)

# 2.0 Boolean Expressions in Ruby
## ex. 1
name == "Bob"

## ex. 2
age <= 35

## ex. 3
age >= 23 && (name == 'Bob' || name == "Jill")

## ex. 4
!(name == "Bob")


# 2.1 The if..else construct
## ex. 1
def check_sign(number)
  if number > 0
    "#{number} is positive"
  elsif number == 0
    "0"
  else
    "#{number} is negative"
  end        
end

## ex. 2
if 0
  puts "Hey, 0 is considered to be a truth in Ruby" 
end

# 2.2 Loops in Ruby
## ex. 1
loop do
  if monk.nirvana?
    break
  else
    monk.meditate
  end
end

## ex. 2
def ring(bell, n)
  i = n
  loop do
    break if i == 0
    bell.ring
    i -= 1
  end
end  

# 3.0 Introduction to Arrays
## ex. 1
(1..5).to_a

## ex. 2
[1, 2, 3, 4, 5, 6, 7][4]

## ex. 3
[1, 2, 3, 4, 5][-1]

## ex. 4
[1, 2, 3, 4, 5] << "woot"

## ex. 5
[1, 2, 3, 4, 5].push("woot")

# 3.1 Basic Array Operations
## ex. 1
[1, 2, 3, 4, 5].map { |i| i * 3 }

## ex. 2
names = ['rock', 'paper', 'scissors', 'lizard', 'spock']
names.select { |s| s.length > 5 }

## ex. 3
[1,3,5,4,6,7].delete(5)

## ex. 4
[1,2,3,4,5,6,7,8,9].delete_if{ |i| i.even? }

# 3.2 Iteration
## ex. 1
restaurant_menu = {}
restaurant_menu["Dal Makhani"] = 4.5
restaurant_menu["Tea"] = 2

## ex. 2
def array_copy(source)
  destination = []
  source.each do |i|
    if i < 4 
      destination << i 
    end
  end
  return destination
end

# 4.0 Introduction to Ruby Hashes
## ex. 1
restaurant_menu = { "Ramen" => 3, "Dal Makhani" => 4, "Tea" => 2}

## ex. 2
restaurant_menu["Ramen"]

## ex. 3
restaurant_menu = {}
restaurant_menu["Dal Makhani"] = 4.5
restaurant_menu["Tea"] = 2

# 4.1 Hashes, in and out.
## ex. 1
restaurant_menu = { "Ramen" => 3, "Dal Makhani" => 4, "Coffee" => 2 }
restaurant_menu.each do |key, value|
  restaurant_menu[key] *= 1.1
end

## ex. 2
restaurant_menu = { "Ramen" => 3, "Dal Makhani" => 4, "Coffee" => 2 }
restaurant_menu.keys  

## ex. 3
def artax
  a = [:punch, 0]
  b = [:kick, 72]
  c = [:stops_bullets_with_hands, false]
  key_value_pairs = Hash[*a, *b, *c]
  Hash[key_value_pairs]
end
p artax

# 5.0 Classes
Object.new

# 5.1 Building your own class
class Rectangle
  def initialize(length, breadth)
    @length = length
    @breadth = breadth
  end

  def perimeter
    2 * (@length + @breadth)
  end

  def area
    @length * @breadth
  end
end

# 6.1 Being Methodical
def add_two num
  num.next.next
end

# 6.2 Calling a method
## ex. 1
def introduction age, gender, *names
  "Meet " << names.join(' ') << ", who's #{age} and #{gender}"
end
## ex. 2
def calculate(*args)
  h = args[-1].is_a?(Hash) ? args.pop : {}

  res = add(*args)
  res = add(*args) if h[:add]
  res = subtract(*args) if h[:subtract]
  res
end

def add(*args)
  args.inject(0) { |sum, num| sum + num }
end

def subtract(*args)
  args.drop(1).inject(args[0]) { |sub, num| sub - num }
end

# 7.1 Lambdas In Ruby
Increment = lambda { |num| num + 1 }

# 7.2 Blocks in Ruby
def calculate a, b
  yield a, b
end

# 8.1 Getting Modular
module Perimeter
  def perimeter
    sum = 0
    sides.each { |side| sum += side }
    sum
  end
end

class Rectangle
  include Perimeter

  def initialize(length, breadth)
    @length = length
    @breadth = breadth
  end

  def sides
    [@length, @breadth, @length, @breadth]
  end
end

class Square
  include Perimeter

  def initialize(side)
    @side = side
  end

  def sides
    [@side, @side, @side, @side]
  end
end

# 8.2 Modules as Namespaces
## ex. 1
module RubyMonk
  module Parser
    class TextParser
      def self.parse str
        str.upcase.chars.to_a
      end
    end
  end
end

## ex. 2
module Kata
  A = 5
  module Dojo
    B = 9
    A = 7
    
    class ScopeIn
      def push
        ::A
      end
    end
  end
end

A = 10

# 9.1 Streams
capture = StringIO.new
$stderr = capture

# 9.2 Using the `File` Class
File.open("disguise", "w+") do |f|
  f.write("Bar")
  puts f.read
end

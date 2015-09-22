# 0.0 Introducing Blocks
Addition = lambda {|a, b| return a + b }

Subtraction = lambda { |a, b| return a - b }

Multiplication = lambda { |a, b| return a * b }

Division = lambda { |a, b| return a / b }

# 0.1 Yield
## ex. 1
def foo
  yield if block_given?
end

## ex. 2
def prettify_it
  res = yield
  res = "The result of the block was: " << res.to_s
end

# 0.2 Implicit and Explicit Blocks
## ex. 1
def filter(array, block)
  return array.select &block
end

## ex. 2
Filter = lambda do |array, &block|
  array.select &block
end

# 1.0 Classification
def know_it_all(object)
  object.class
end

# 1.1 Understanding Inheritance
def is_ancestor?(klass, subclass)
  subclass.superclass == klass ||
  subclass.superclass.superclass == klass
end

# 1.2 Inheriting Class
class Rectangle
  def initialize(length, breadth)
    @length = length
    @breadth = breadth
  end

  def perimeter
    2 * (@length + @breadth)
  end
end

class Square < Rectangle
  def initialize(length)
    @length = length
    @breadth = length
  end
end

# 1.3 Redefining, overriding, and super
## ex. 1
class Fixnum
  def +(a)
    42
  end

## ex. 2
class Animal
  def move
    "I can move"
  end
end

class Bird < Animal
  def move
    super + " by flying"
  end
end

class Human < Animal
  def move
    super + " by walking"
  end
end

class Penguin < Bird
  def move
    "I can move by swimming"
  end
end

# 2.0 Instance Variables and Accessors
## ex. 1
class Item
  def initialize(description, color)
    @description = description
    @color = color
  end
  
  def description
    @description.to_s + @color.to_s
  end
end

## ex. 2
class Item
  def initialize(item_name, quantity)
    @item_name = item_name
    @quantity = quantity
  end
  
  def quantity=(new_quantity)
    @quantity = new_quantity
  end
  
  def quantity
    @quantity
  end  
end

item = Item.new("a",1)
item.quantity = 3

## ex. 3
class Item
  attr_writer :description, :color  
  def initialize(description, color)
    @description = description
    @color = color
  end
end

# 2.1 Class Variables and Methods
## ex. 1
class ApplicationConfiguration
  @@props = {}
  def self.set(property_name, value)
    @@props[property_name] = value
  end
  
  def self.get(property_name)
    @@props[property_name]
  end  
end

ApplicationConfiguration.set("name", "Demo Application")
ApplicationConfiguration.set("version", "0.1")

p ApplicationConfiguration.get("version")

## ex. 2
class ApplicationConfiguration
  @configuration = {}

  def self.set(property, value)
    @configuration[property] = value
  end

  def self.get(property)
    @configuration[property]
  end
end

class ERPApplicationConfiguration < ApplicationConfiguration
  @configuration = {}
end

class WebApplicationConfiguration < ApplicationConfiguration
  @configuration = {}
end

ERPApplicationConfiguration.set("name", "ERP Application")
WebApplicationConfiguration.set("name", "Web Application")

p ERPApplicationConfiguration.get("name")
p WebApplicationConfiguration.get("name")

p ApplicationConfiguration.get("name")

# 2.2 Equality of Objects
## ex. 1
class Item
    attr_reader :item_name, :qty
    
    def initialize(item_name, qty)
        @item_name = item_name
        @qty = qty
    end
    def to_s
        "Item (#{@item_name}, #{@qty})"
    end
    def ==(other_item)
      @item_name == other_item.item_name &&
      @qty == other_item.qty
    end
end

p Item.new("abcd",1)  == Item.new("abcd",1)
p Item.new("abcd",2)  == Item.new("abcd",1)

## ex. 2
class Item
  attr_reader :item_name, :quantity, :price
  
  def initialize(item_name, quantity, supplier_name, price)
    @item_name = item_name
    @quantity = quantity
    @supplier_name = supplier_name
    @price = price
  end 
  
  def ==(item2)
    @item_name == item2.item_name &&
    @quantity == item2.quantity &&
    @price == item2.price
  end
  
  def hash
    @item_name.hash ^ @quantity.hash ^ @price.hash
  end
  
  def eql?(item2)
    self.==(item2)
  end
end

# 2.3 Displaying Objects: puts and p, to_s and inspect
class Item
  def initialize(item_name, qty)
    @item_name = item_name
    @qty = qty
  end
  
  def to_s
    @item_name + @qty.to_s
  end 
end

item = Item.new("a",1)

puts item
p item

# 2.4 Serializing
## ex. 1
class CerealBox
  attr_accessor :ounces, :contains_toy
  
  def initialize(ounces, contains_toy)
    @ounces = ounces
    @contains_toy = contains_toy
  end
  
  def self.from_s(s)
    ounces = 0
    contains_toy = false
    s.each_line do |field|
      value = field.split(":")[1].strip
      ounces = value.to_i if field.include?("ounces")
      contains_toy = to_boolean(value) if field.include?("contains_toy")
    end
    CerealBox.new(ounces, contains_toy)
  end
  
  def self.to_boolean(str)
    str == 'true'
  end
  
  def to_s
    "ounces:#{@ounces}\ncontains_toy:#{@contains_toy}"
  end
end

puts "example to_s: #{CerealBox.new(4, true).to_s}"

puts "example from_s: #{CerealBox.from_s(CerealBox.new(10, false).to_s)}"

## ex. 2
class Ogre
  attr_accessor :strength, :speed, :smell
  def initialize(strength, speed, smell)
    @strength = strength
    @speed = speed
    @smell = smell
  end
end

class Dragon
  attr_accessor :strength, :speed, :color
  def initialize(strength, speed, color)
    @strength = strength
    @speed = speed
    @color = color
  end
end

class Fairy
  attr_accessor :strength, :speed, :intelligence
  def initialize(intelligence)
    @strength = 1
    @speed = 42
    @intelligence = intelligence
  end
end

def save_game(characters)
  gf = GameFile.new('characters.yaml')
  gf.write(YAML::dump(characters))
end

def load_game
  gf = GameFile.new('characters.yaml')
  YAML::load(gf.read)
end

# 3.0 Ripping the Guts
## ex. 1
def compute(ary)
  return nil if ary == nil 
  ary.map { |a, b| b == nil ? a : a + b }
end

## ex. 2
first, *middle, last = [42, 43, 44, 45, 46, 47]

## ex. 3
def median(*list)
  med = 0
  list.each { |arg| med += arg }
  return nil if list.count == 0
  res = med / (list.count + 0.0)
  res.to_i == res ? res.to_i : res
end

# 3.1 Using the API
## ex. 1
[4, 8, 15, 16, 23, 42].count { |e| e.even? }

## ex. 2
def zen(array)
  arr = array.flatten.compact
  arr.index(42) == 5 ? arr.length : nil
end

## ex. 3
def few2last(array)
  array.slice(-2..-1).join('|')
end

# 3.2 Stacks and Queues
## ex. 1
class Stack
  def initialize(size)
    @arr = Array.new
    @size = size
  end
  
  def pop
    @arr.pop
  end
  
  def push(element)
    if full? || element == nil
      nil
    else
      @arr.push(element)
      self
    end
  end
  
  def size
    @size
  end
  
  def look
    @arr[-1]
  end
  
  private
  
  def full?
    @arr.size == @size
  end
  
  def empty?
    @arr.size == 0
  end
end

## ex. 2
class Queue
  def initialize(size)
    @arr = Array.new
    @size = size
  end
  
  def dequeue
    @arr.pop
  end
  
  def enqueue(element)
    if full? || element == nil
      nil
    else
      @arr.unshift(element)
      self
    end
  end
  
  def size
    @size
  end
  
  private
  
  def full?
    @arr.size == @size
  end
  
  def empty?
    @arr.size == 0
  end
end

# 3.3 Alternative Uses
## ex. 1
class WaiterRobot

  def initialize(chef, tables)
    @chef = chef
    @tables = tables
    @name = "Tyler Durden"
  end
  
  def name
    @name
  end
  
  def place_order(table_number, sandwich, drink)
    @chef.new_order(self, {table: table_number, sandwich: sandwich, drink: drink})
  end
  
  def serve(order)
    order = Hash[*order]
    @tables[order[:table]].serve_sandwich(order[:sandwich])
    @tables[order[:table]].serve_drink(order[:drink])
  end
  
end

## ex. 2
CHARACTERS = ["Joey Jeremiah", "Snake Simpson", "Wheels", "Spike Nelson", "Arthur Kobalewscuy", "Caitlin Ryan", "Shane McKay", "Rick Munro", "Stephanie Kaye"]

def degrassi_couples
  CHARACTERS.product(CHARACTERS).select { |p| p[0] != p[1] }
end

## ex. 3
class Announcements
  def initialize(printer)
    @printer = printer
  end
  
  def notify_user(column_table)
    row_table = column_table.transpose
    @printer.print_with_ink(row_table)
  end
end

# 4.1 The `included` Callback and the `extend` Method
## ex. 1
module Foo
  def method_in_module
   	"The method defined in the module invoked"
  end
end

class Bar
  def initialize
    self.extend Foo
  end
end

## ex. 2
module Foo
  module ClassMethods
    def guitar
      "gently weeps"
    end
  end
  
  def self.included(klass)
    klass.extend ClassMethods
  end
end

class Bar
  include Foo
end

puts Bar.guitar


# 4.2 Wrapping Up Modules
module Math
  def self.square(a)
    a**2
  end
end

puts Math.square(6) 

# 5.0 Handling and Raising
## ex. 1
EXAMPLE_SECRETS = ["het", "keca", "si", nil, "iel"]

def decode(jumble)
  secret = jumble.split("").rotate(3).join("")
  announce(secret)
  secret
end

def decode_all array
  array.each { |el| decode el }
  rescue Exception
end

## ex. 2
EXAMPLE_SECRETS = ["het", "keca", "si", nil, "iel"]

def decode(jumble)
  secret = jumble.split("").rotate(3).join("")
  announce(secret)
  secret
end

def decode_all array
  array.each { |el| decode el } rescue "it's okay, little buddy."
end

## ex. 3
class UserDataAccess
  attr_accessor :db
  
  def initialize
    @db = Database.new
  end

  def find_user(name)
  	@db.find("SELECT * FROM USERS WHERE NAME = '%'", name)
    rescue Exception => e
    puts "A database error occurred."
    ensure @db.close
  end
end

## ex. 4
def string_slice *args
  res = []
  raise ArgumentError if args.count > 5
  args.each do |arg|
    raise IndexError if arg.size < 3
    res.push arg.slice(0,3)
  end
  res
end

## 5.1 Tidying Things Up
def robe(type)
  raise KasayaError unless type.downcase == "kasaya"
  "Dharmaguptaka's Kasaya Robe"
end

# 5.2 Throw and Catch
floor = [["blank", "blank", "blank"],
         ["gummy", "blank", "blank"],
         ["blank", "blank", "blank"]]

def search floor
  floor.each do |row|
  	row.each do |tile|
      return tile if tile == "jawbreaker" || tile == "gummy"
  	end
  end
end

candy = search floor
puts candy

# 6.1 Literals
## ex. 1
def an_array_with_5_elements
  [1]*5
end

def a_string_longer_than_10_characters
  "a"*11
end

def a_number_with_a_decimal_place
  1.0
end

def an_array_of_hashes
  [{}]
end

def an_array_of_arrays
  [[]]
end

## ex. 2
def big_num
  1_234_567_890_123_456_789_123_456_789
end

describe(big_num)

## ex. 3
def quoted_string(to_be_quoted)
  "Suuuure. You were just \"#{to_be_quoted}\"."
end

## ex. 4
def multi_line_string(*lines)
  "Here are your lines!\n\n" + lines.join("\n")
end

## ex. 5
def big_q_string(numerator, denominator)
  %Q{This %Q syntax is the ugliest one.\n#{numerator} out of #{denominator} \"dentists\" agree.}
end

## ex. 6
def repetitive_array_of_strings
  ["Wow,", "this", "is", "a", "pretty", "long", "list", "of", "words", "and", "it", "took", "me", "a", "long", "time", "to", "type", "because", "of", "all", "those", "darn", "quote", "characters.", "Geez."] 
end

def array_of_words_literal
  %w(With this double-u shorthand it wasn't very hard at all to type out this list of words. Heck, I was even able to use double-quotes like "these"!)
end

## ex. 7
def one_less
  1...10
end

## ex. 8
def range_of_characters
  'a'..'z'
end

# 6.2 Variables
def last_error
  $@
end

def this_script_name
  $0
end

# 6.3 Constants
## ex. 1
Argument::Truth = "No, you're not."

## ex. 2
def awkward_sheep
  sheep = Class.new do 
    def speak
      "Bah."
    end
  end
end

## ex. 3
module Fence
  SHEEP = Class.new do
    def speak
      "Bah."
    end
  end
end

def call_sheep
  sheep = Fence::SHEEP.new
  sheep.speak
end

# 7.0 Enumerators and Enumerables
class Array
  def map_with_index &block
    self.map.with_index &block
  end
end

# 7.1 Iterate, Filtrate and Transform
## ex. 1
def hash_keys(hash)
  hash.map { |key, val| key }
end

# ex. 2
def occurrences(str)
	str = str.downcase.gsub(/[^a-z\s]/, '').split(' ')
  str.uniq.inject({}) { |accum, iter| accum.update(iter => str.count(iter)) }
end

## ex. 3
class Island
  def initialize(candidates)
    @candidates = candidates
  end
  
  def survive?
    @candidates.none? { |i| i == "Esau" }
  end
  
  def safe?
    @candidates.all? { |i| i == "Jack" }
  end
end

## ex. 4
class Order
  GIFT_ITEMS = [Item.new(:big_white_tshirt), Item.new(:awesome_stickers)]
  OUT_OF_STOCK_ITEMS = [Item.new(:ssd_harddisk)]

  def initialize(order)
    @order = order || []        
  end
  
  def final_order
    @order -= OUT_OF_STOCK_ITEMS
    @order += GIFT_ITEMS
    @order
  end
end

customer_order = Order.new([Item.new(:fancy_bag),Item.new(:ssd_harddisk)])

p customer_order.final_order

# 7.2 Building Collections
## ex. 1
class FibonacciNumbers
  NUMBERS = [1, 1, 2, 3, 5, 8, 13, 21, 34, 55]
    
  def each
    i = 0
    while i < NUMBERS.size
      yield(NUMBERS[i])
      i += 1
    end
  end
end

f=FibonacciNumbers.new
f.each do |fibonacci_number|
  puts "A Fibonacci number multiplied by 10: #{fibonacci_number*10}"
end

## ex. 2
class FibonacciNumbers
  include Enumerable
  
  NUMBERS = [1, 1, 2, 3, 5, 8, 13, 21, 34, 55]
  
  def each
    i = 0
    while i < NUMBERS.size
      yield(NUMBERS[i])
      i += 1
    end
  end
end

f = FibonacciNumbers.new
if f.respond_to?(:map)
  squares = f.map {|number| number * number }
	puts "The squares of the fibonacci numbers are #{squares}"
else
  puts "I'll reveal the squares to you once you pass the tests."
end

# 7.3 Object References
a = "tom"
b = "jerry"
superheroes = [a,b]

superheroes[1] = "batman"

# 8.1 The Debugging Primaries
## ex. 1
def describe(user_info)
  p user_info
  "My name is #{user_info["name"]} and I'm #{user_info["age"]} years old."
end

## ex. 2
class VisualAcuity
  def initialize(subject, normal)
    @subject, @normal = subject.to_f, normal.to_f
  end
  
  def can_drive?
    (@subject / @normal) >= 0.5
  end  
end

class DrivingLicenseAuthority
  def initialize(name, age, visual_acuity)
    if name == "Muluc"
    p visual_acuity
    end
    @name, @age, @visual_acuity = name, age, visual_acuity
  end
  
  def valid_for_license?
    @age >= 18 && @visual_acuity.can_drive?
  end
  
  def verdict
    if valid_for_license?
	  "#{@name} can be granted driving license"
    else
      "#{@name} cannot be granted driving license"
    end
  end
end

# 8.2 Logging
require 'logger'

class Order
  def initialize(order_items, customer)
    @order_items = order_items
    @customer = customer
    @state = :new
    @logger = Logger.new(STDOUT)
    @logger.info "customer name: #{@customer}"
  end

  def procure(vendor)
    if @state == :new
	  @vendor = vendor
	  @state = :procured
      @logger.info "vendor: #{@vendor}, state: #{@state}"
    end
  end

  def pack
    if @state == :procured
	  @state = :packed
      @logger.info "packed at #{Time.now}"
    else
      @logger.error "packing w/o procuring!"
    end
  end

  def ship(address)
    if @state == :packed
	  @state = :shipped
	  @shipping_address = address
      @logger.info "address: #{@shipping_address}, state: #{@state}"
    else
      @logger.error "shipping w/o packing!"
    end
  end
end

order = Order.new(["mouse", "keyboard"], "Asta")
order.procure("Awesome Supplier")
order.pack
order.ship("The Restaurant, End of the Universe")

# 8.3 Benchmarking Ruby Code
def benchmark
  start = Time.now
  yield
  Time.now - start
end

time_taken = benchmark do
  sleep 0.1
end
puts "Time taken #{time_taken}"

# 9.2 What is an object?
class Dish
end
class Soup < Dish
end
class IceCream < Dish
end
class ChineseGreenBeans < Dish
end

class DeliveryTray
  DISH_BOWL_MAPPING = { 
    Soup => "soup bowl",
    IceCream => "ice cream bowl",
    ChineseGreenBeans => "serving plate"
  }
    
  def initialize
    @dishes = { Soup => 0, IceCream => 0, ChineseGreenBeans => 0}
  end
  
  def add(dish)
    @dishes[dish.class] += 1
  end
  
  def dishes_needed
    res = @dishes.select { |d, v| v > 0 } .map { |d,v| "#{v} #{DISH_BOWL_MAPPING[d]}" } .join(', ')
    res == [] ? "None." : res
  end
end  

d = DeliveryTray.new
d.add Soup.new; d.add Soup.new
d.add IceCream.new

puts d.dishes_needed # should be "2 soup bowl, 1 ice cream bowl"

# 9.3 Behaviour
class Object
  def superclasses
    res = []
    cclass = self.superclass
    while cclass != nil
      res << cclass
      cclass = cclass.superclass
    end
    res
  end
end

class Bar
end

class Foo < Bar
end

p Foo.superclasses  # should be [Bar, Object, BasicObject]

# 9.4 Singleton methods and metaclasses
class Object
  def singleton_method?(method)
    self.singleton_methods.include? method
  end
end

foo = "A string"
def foo.shout
  puts foo.upcase
end

p foo.singleton_method?(:shout)

# 9.5 Cloning and freezing objects
class Object
  def frozen_clone
    self.clone.freeze
  end
end


#problem - Hiring Programmers - Boolean Expressions in Ruby
is_an_experienced_programmer = 
(
  candidate.languages_worked_with.include?('Ruby') && \
  !candidate.applied_recently? && \
  candidate.age >= 15
) && \
(
  candidate.years_of_experience >= 2 || \
  candidate.github_points >= 500
)

# problem - Select random elements from an array
def random_select(array, n)
  arr = []
  (1..n).each { |n| arr << array[rand(array.length)] }
  arr
end

# problem - Build a calculator that performs addition and subtraction
class Calculator
  def add(a, b)
    a + b
  end

  def subtract(a, b)
    a - b
  end
end

# problem - Your Sum
class MyArray
  attr_reader :array

  def initialize(array)
    @array = array
  end

  def sum(initial_value = 0, b = {})
    s = initial_value
    @array.each { |el| s += block_given? ? yield(el) : el }
    s
  end
end

# problem - Orders and costs
class Restaurant
  def initialize(menu)
    @menu = menu
  end

  def cost(*orders)
    sum = 0
    orders.each { |order| order.each { |item, price| sum += (@menu[item] * price) } }
    sum
  end
end

# problem - Number Shuffle
def number_shuffle(number)
  number.to_s.chars.to_a.permutation.map(&:join).map(&:to_i).uniq
end

# problem - Find the length of strings in an array
def length_finder(input_array)
  arr = []
  input_array.each { |item| arr.push(item.length) }
  arr
end

# problem - Palindromes
def palindrome?(sentence)
  raw_str = sentence.gsub(/ +/, "").downcase
  raw_str == raw_str.reverse
end

# problem - Find the frequency of a string in a sentence
def find_frequency(sentence, word)
  sentence.downcase.split(' ').count(word.downcase)
end

# problem - Sort the words in a given sentence
def sort_string(string)
  string.split(' ').sort_by { |word| word.length } .join(' ')
end

# problem - Compute sum of cubes for given range
def sum_of_cubes(a, b)
  sum = 0
  (a..b).each { |n| sum += n**3 }
  sum
end

# problem - Find non-duplicate values in an Array
def non_duplicated_values(values)
  arr = []
  values.each { |val| values.count(val) == 1 ? arr.push(val) : nil }
  arr
end

# problem - Check if all elements in an array are Fixnum
def array_of_fixnums?(array)
  yes = 0
  array.each { |num| num.is_a?(Fixnum) ? nil : yes += 1 }
  yes == 0
end

# problem - Kaprekar's Number
def kaprekar?(k)
  kk = (k**2).to_s
  n = k.to_s.length
  var_1 = [kk[0..n-1], kk[n..-1]]
  var_2 = [kk[0..n-2], kk[n-1..-1]]
  k == var_1.map(&:to_i).inject(:+) || k == var_2.map(&:to_i).inject(:+)
end

# problem - Enough Contrast?
class Color
  attr_reader :r, :g, :b
  def initialize(r, g, b)
    @r = r
    @g = g
    @b = b
  end

  def brightness_index
    ( 299*@r + 587*@g + 114*@b) / 1000
  end

  def brightness_difference(col)
    (brightness_index - (( 299*col.r + 587*col.g + 114*col.b) / 1000)).abs
  end

  def hue_difference(col)
    (@r - col.r).abs + (@g - col.g).abs + (@b - col.b).abs 
  end

  def enough_contrast?(col)
    brightness_difference(col) > 125 &&
    hue_difference(col) > 500
  end
end

# problem - Time to run code
def exec_time(proc)
  start = Time.now
  proc.call
  Time.now - start
end

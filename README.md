# Define Class
## class with no argument
```ruby
class Item
  def initialize()
  end
end
```

## create with 1 argument
```ruby
class Item
  def initialize(name)
  end
end
```

# Create object
```ruby
item1 = Item.new()
item2 = Item.new("apple")
```

# Include other file
```ruby
require "./item" # read file item.rb under the current folder and insert it
```

# instance variable (start with @)
```ruby
class Item
  def initialize(name)
    @name = name
  end
  def print()
    puts @name
  end
end
Item.new("apple").print() #=> "apple"
```

# instance method
## declear method
```ruby
class Item
  def initialize()
  end
  def price(quantity)
    10 * quantity # result of the last line returns automatically
  end
end
```

## call method
```ruby
price = Item.new().price(5) #=> 50
```

# Condition
## if statement
```ruby
if (1 == 1)
  puts "case1"
elsif (2 == 2)
  puts "case2"
else
  puts "case3"
end
```

## switch statement
```ruby
case 1
when 1
  puts "1"
when 2
  puts "2"
end
```

# String
## create string
```ruby
name = "apple"
```

## append string
```ruby
name = "apple"
puts name + "orange" #=> apple orange
```

## combine strings
```ruby
name = "apple"
puts "having #{name}" #=> having apple
```

# Array
## create empty array
```ruby
array = []
```

## add item to array
```ruby
array = []
array << "mlik"
```

## get item by index
```ruby
array = ["apple", "orange"]
array[0] #=> "apple"
```

## find index of item
```ruby
array = ["apple", "orange"]
array.index("apple") #=> 0
```

## loop through each item
```ruby
array = ["apple", "orange"]
array.each do |item|
  puts item # execute this line for each item
end #=> "apple\norange"
array.each { |item| puts item } # same as above
```

## map to create a new array with different value
```ruby
array = [1,2,3]
array.map do |item|
  item * 3
end #=> [3,6,9]
```

# Minitest
## file name ends with "_test.rb"
## basic format
```ruby
require 'minitest/autorun'
describe "math" do            # 'describe' block wraps 'it' blocks
  it "can sum two numbers" do # 'it' block represents single test
    assert_equal(2, 1 + 1)    # assertion
  end
end
```

## assetion
```ruby
expected = true
actual = (1 + 1 == 2)
assert_equal(expected, actual)
```

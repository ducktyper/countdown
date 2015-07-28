## Coding practice
Goal: Teaching ruby to newbies

We will build a self-checkout machine used in a supermarket together.

### Task 3
#### TODO
Checkout to the start point of Task 3
```ruby
git checkout task3
```
Use ActiveRecord to persist data to SQLite
#### Requirements
* Install ActiveRecord and SQLite
* Setup ActiveRecod to talk to SQLite memory storage
* Define database tables to save products, discounts, and purchases
* Extend Product, Discount, and Purchase classes to ActiveRecord::Base
* Set relationships of each tables in models
* purchase_summary shows hour:minute:second applying New Zealand Timezone
```ruby
store.purchase_summary() #=>
[
  ["Time","Number of Products","Cost"],
  ["17/07/2015 00:00:00",2,20.0],
  ["18/07/2015 00:00:00",1,15.99]
]
```
* Raise an error if product and discount are not valid

Product: barcode and name should exist and cost should be bigger than 0

Discount: amount should be bigger than 0

#### ActiveRecord syntax
##### setup
Tell ruby which gems (libraries) to use (activerecord and sqlite3 gems in this case)
```ruby
# create ./Gemfile to top folder and type below
source 'https://rubygems.org'

gem 'sqlite3', '1.3.10'
gem 'activerecord', '4.2.0'
```
install gems
```ruby
# type this command on the top folder in termimal
bundle install
```
load active_record gem to use
```ruby
require 'active_record'
```
setup connection to SQLite memory storage
```ruby
ActiveRecord::Base.establish_connection adapter: "sqlite3", database: ":memory:"
```
##### Create database tables
[More info](https://github.com/rails/rails/blob/4-2-stable/activerecord/lib/active_record/schema.rb)
```ruby
ActiveRecord::Schema.define do
  # create cars table with 5 fields (actually 6 in total including id)
  create_table "cars" do |t|
    t.string   "name",        limit: 255
    t.integer  "year",        limit: 4
    t.integer  "owner_id",    limit: 4
    t.decimal  "price",       precision: 8, scale: 2
    t.datetime "purchased_at"
  end
  # create table connect cars and drivers in many to many relationship
  # set {id: false} if no need direct access to this table
  create_table "cars_drivers", id: false do |t|
    t.integer  "car_id",      limit: 4
    t.integer  "driver_id",   limit: 4
  end
  create_table "drivers" do |t|
    t.string   "name",        limit: 255
  end
  create_table "ownsers" do |t|
    t.string   "name",        limit: 255
  end
end
```
##### Create Class to represent each table and setup relations
[More info](http://guides.rubyonrails.org/association_basics.html)
```ruby
class Car < ActiveRecord::Base
  has_and_belongs_to_many :drivers
  belongs_to :owner
end
class Driver < ActiveRecord::Base
  has_and_belongs_to_many :cars
end
class Owner < ActiveRecord::Base
  has_many :cars
end
```
Usage
```ruby
Car.first.drivers # get drivers of the first car in the database through cars_drivers table
```

##### Find records
[More info](http://guides.rubyonrails.org/active_record_querying.html)
```ruby
# find a car having id = 1
Car.find(1)
# find a car having name = "A4"
Car.find_by(name: "A4")
# find cars having name = "A4"
Car.where(name: "A4")
Car.where("cars.name = ?", "A4")
Car.where("cars.name = :name", name: "A4")
# use relations
Car.find(1).drivers
Car.find(1).owner
Owner.find(1).cars
# find cars which owner's name = "bob"
Car.joins(:owner).where(owners: {name: "bob"})
# count records
Car.count
Car.where(name: "A4").count
```

##### Validation
[More info](http://guides.rubyonrails.org/active_record_validations.html)

set validation
```ruby
class Car < ActiveRecord::Base
  validates :name,  presence: true # name should exist
  validates :price, numericality: {greater_than: 0}
end
```
check validation
```ruby
Car.new(name: "", price: 0).valid? #=> false
```
validation is also called in save and update methods
```ruby
Car.new(name: "", price: 0).save     #=> false
Car.first.update(name: "", price: 0) #=> false
```

##### Time zone in Rails
[More info](http://api.rubyonrails.org/classes/ActiveSupport/TimeZone.html)

ActiveRecord saves time data to database as UTC (+0 hours). Time zone is required when
we display data to the end user. Once you set time zone, time.zone methods
(example: Time.zone.now) and active record's time data methods
(example: Car.first.purchased_at) return the time with that time zone.

Even you set Time.zone, ruby time methods like Time.now (without 'zone') will
return the time with time zone set in your OS.


Use time zone to ActiveRecord (aleady set in Rails)
```ruby
ActiveRecord::Base.time_zone_aware_attributes = true
```
Set time zone
```ruby
Time.zone = "Pacific/Auckland"
```
Useage
```ruby
Time.zone.now          # Mon, 27 Jul 2015 19:00:19 NZST +12:00
Car.first.purchased_at # Mon, 27 Jul 2015 19:00:19 NZST +12:00
```

### Task 2

#### TODO
Implement new requirements to store.rb and store_test.rb. Reading Ruby syntax will be useful to do this task.
#### Requirements
* Receipts show costs including cents (example: apple $5.00)

* Customers can purchase products which returns the receipt
```ruby
store.purchase(["0001", "0002"]) #=>
apple $5.00
orange $10.00
total $15.00
```
* Owner can view purchase summary as data array
```ruby
store.purchase_summary() #=>
[
  ["Time","Number of Products","Cost"],
  ["17/07/2015",2,20.0],
  ["18/07/2015",1,15.99]
]
```
* Owner can add discount to a product
```ruby
store.add_discount("0001", 1) #=> $1 discount to product "0001"
```
* Owner can delete discount to a product
```ruby
store.delete_discount("0001") #=> delete discount to product "0001"
```
* Extra Task: Save products, purchases, discounts to SQL database using ActiveRecord with SQLite.
ActiveRecord is M in MVC from Ruby on Rails framework. We will go through how to use this library
in next class

#### Ruby syntax
##### Format string
[More info](http://ruby-doc.org/core-2.1.0/String.html)
```ruby
"display float %.1f" % 1 #=> display float 1.0
```

##### Time
[More info](http://ruby-doc.org/core-2.1.0/Time.html)
```ruby
Time.now            #=> 2015-07-19 20:32:52 +1200
Time.new(2015,7,19) #=> 2015-07-19 00:00:00 +1200
Time.new(2015,7,19).strftime("%Y-%m-%d") #=> "2015-07-19"
```

### Task 1

#### TODO
As a tester, remove store_test.rb and recreate it from store.rb

As a developer, remove store.rb and recreate it to pass store_test.rb

As a passinate person, remove store_test.rb and store.rb and create them using TDD

#### Requirements

User can add an item to store
```ruby
store.add_item("0001", "apple", 10) # add $10 apple with barcode 0001
```
User can count stored items
```ruby
store.item_count() #=> 10 (10 items)
```
User can calculate total cost of given items
```ruby
store.calculate_cost(["0001", "0001"]) #=> 20 (two apples costs $20)
```
User can print receipt of given items
```ruby
store.print_receipt(["0001", "0001"]) #=>
apple $10
apple $10
total $20
```

#### Setup environment
##### Using Windows + Rubymine (not free)
1. Install railsinstaller from http://railsinstaller.org/en (WINDOWS RUBY 2.1)
2. Install Rubymine from https://www.jetbrains.com/ruby/ (Not free but students can get 1 year license)
3. Clone this project
  * Run Rubymine
  * Welcome page -> check out from Version Control -> Git
  * Fill Repository info and click clone
    * Git Repository URL "https://github.com/ducktyper/countdown.git"
    * Parent Directory   "choose where you want to save this project in your computer"
    * Directory Name     "countdown"
4. Run test
  * toolbar -> click 'run' -> click 'Run' -> choose 1. All tests in countdown

##### Using Windows + Sublime Text (free)
1. Install railsinstaller from http://railsinstaller.org/en (WINDOWS RUBY 2.1)
2. Install Sublime Text from https://http://www.sublimetext.com
3. Clone this project
  * Open Terminal
  * Move to where you want to clone the project (Example: C:\Users\daniel\Desktop\projects)
  * git clone https://github.com/ducktyper/countdown.git
4. Open cloned folder from Sublime Text
5. Open score_test.rb file and click Ctrl-b to run test


Here is basic ruby syntax useful to this task.

#### Ruby Syntax
##### Define Class
[More info](http://ruby-doc.org/core-2.1.0/Class.html)
###### class with no argument
```ruby
class Item
  def initialize()
  end
end
```

###### create with 1 argument
```ruby
class Item
  def initialize(name)
  end
end
```

###### Create object
```ruby
item1 = Item.new()
item2 = Item.new("apple")
```

###### Include other file
```ruby
require "./item" # read file item.rb under the current folder and insert it
```

###### instance variable (start with @)
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

###### instance method
* declear method
```ruby
class Item
  def initialize()
  end
  def price(quantity)
    10 * quantity # result of the last line returns automatically
  end
end
```

* call method
```ruby
price = Item.new().price(5) #=> 50
```

###### Condition
* if statement
```ruby
if (1 == 1)
  puts "case1"
elsif (2 == 2)
  puts "case2"
else
  puts "case3"
end
```

* switch statement
```ruby
case 1
when 1
  puts "1"
when 2
  puts "2"
end
```

###### String
[More info](http://ruby-doc.org/core-2.1.0/String.html)
* create string
```ruby
name = "apple"
```

* append string
```ruby
name = "apple"
puts name + "orange" #=> apple orange
```

* combine strings
```ruby
name = "apple"
puts "having #{name}" #=> having apple
```

##### Array
[More info](http://ruby-doc.org/core-2.1.0/Array.html)
* create empty array
```ruby
array = []
```

* add item to array
```ruby
array = []
array << "mlik"
```

* get item by index
```ruby
array = ["apple", "orange"]
array[0] #=> "apple"
```

* find index of item
```ruby
array = ["apple", "orange"]
array.index("apple") #=> 0
```

* loop through each item
```ruby
array = ["apple", "orange"]
array.each do |item|
  puts item # execute this line for each item
end #=> "apple\norange"
array.each { |item| puts item } # same as above
```

* map to create a new array with different value
```ruby
array = [1,2,3]
array.map do |item|
  item * 3
end #=> [3,6,9]
```

##### Hash
[More info](http://ruby-doc.org/core-2.1.0/Hash.html)

A Hash is a dictionary-like collection of unique keys and their values.
Same as 'Dictionary' in C#, 'Object Properties' in Javascript.

* create empty hash
```ruby
hash = {}
```

* add key and value pair
```ruby
hash = {}
hash["key"] = "value"
```

* get value from key
```ruby
hash = {"key" => "value"}
hash["key"] #=> "value"
```

##### Symbol
[More info](http://ruby-doc.org/core-2.1.0/Symbol.html)

Symbol is like string but faster to compare equality.
It is popular using Symbol as key in Hash.

* Use Symbol in Hash
```ruby
hash = {:name => "apple", :price => 10}
```

* Short syntax using Symbol in Hash
```ruby
hash = {name: "apple", price: 10}
```

##### Methods for array like classes
[More info](http://ruby-doc.org/core-2.1.0/Enumerable.html)

* Inject to compose data
```ruby
# update 0 5 times (0 -> 1 -> 3 -> 6 -> 10 -> 15) and return
[1, 2, 3, 4, 5].inject(0) do |total, number|
  total + number
end #=> 15
```

##### Minitest
file name ends with "_test.rb"

* basic format
```ruby
require 'minitest/autorun'
describe "math" do            # 'describe' block wraps 'it' blocks
  it "can sum two numbers" do # 'it' block represents single test
    assert_equal(2, 1 + 1)    # assertion
  end
end
```

* assertion
```ruby
expected = true
actual = (1 + 1 == 2)
assert_equal(expected, actual)
```

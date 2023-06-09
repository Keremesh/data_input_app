# {Spaces}} Model and Repository Classes Design Recipe

## 1. Design and create the Table


## 2. Create Test SQL seeds

Your tests will depend on data stored in PostgreSQL to run.



## 3. Define the class names

Usually, the Model class name will be the capitalised table name (single instead of plural). The same name is then suffixed by `Repository` for the Repository class name.

```ruby
# EXAMPLE
# Table name: spaces

# Model class
# (in lib/space.rb)
class Space
end

# Repository class
# (in lib/space_repository.rb)
class SpaceRepository
end
```

## 4. Implement the Model class

Define the attributes of your Model class. You can usually map the table columns to the attributes of the class, including primary and foreign keys.

```ruby
# EXAMPLE
# Table name: spaces

# Model class
# (in lib/space.rb)

class Space

  # Replace the attributes by your own columns.
  attr_accessor :title, :description, :price, :address, :available_dates, :user_id
end


```

*You may choose to test-drive this class, but unless it contains any more logic than the example above, it is probably not needed.*

## 5. Define the Repository Class interface

Your Repository class will need to implement methods for each "read" or "write" operation you'd like to run against the database.

Using comments, define the method signatures (arguments and return value) and what they do - write up the SQL queries that will be used by each method.

```ruby
# EXAMPLE
# Table name: students

# Repository class
# (in lib/space_repository.rb)

class SpaceRepository

  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    # SELECT title, description, price, address, available_dates, user_id FROM spaces;

    # Returns an array of Space objects.
  end

  def create(space)
  INSERT INTO spaces (title, description, price, address, available_dates, user_id) VALUES ($1, $2, $3, $4, $5, $6);

  end

  # Gets a single record by its ID
  # One argument: the id (number)
  # def find(id)
    # Executes the SQL query:
    # SELECT id, name, cohort_name FROM students WHERE id = $1;

    # Returns a single Student object.
  # end

  # Add more methods below for each operation you'd like to implement.

  # def create(student)
  # end

  # def update(student)
  # end

  # def delete(student)
  # end
end
```

## 6. Write Test Examples

Write Ruby code that defines the expected behaviour of the Repository class, following your design from the table written in step 5.

These examples will later be encoded as RSpec tests.

```ruby
# EXAMPLES

# 1
# Get all spaces

repo = SpaceRepository.new

space = repo.all

space.length # =>  4

space[0].id # =>  1
space[0].title # =>  'Title1'
space[0].description # =>  'description1'
space[0].price # => '12.00'
space[0].address # => 'Address1'
space[0].available_dates # => '[2010-01-13 14:30:01, 2010-01-14 15:30:01]'
space[0].user_id # => '1'

space[1].id # =>  2
space[1].title # =>  'Title2'
space[1].description # =>  'description2'
space[1].price # => '12.00'
space[1].address # => 'Address2'
space[1].available_dates # => '[2010-01-14 14:30:01, 2010-01-15 15:30:01]'
space[1].user_id # => '2'

# 2
# Get a single student

repo = StudentRepository.new

student = repo.find(1)

student.id # =>  1
student.name # =>  'David'
student.cohort_name # =>  'April 2022'

# Add more examples for each method
```

Encode this example as a test.

## 7. Reload the SQL seeds before each test run

Running the SQL code present in the seed file will empty the table and re-insert the seed data.

This is so you get a fresh table contents every time you run the test suite.

```ruby
# EXAMPLE

# file: spec/space_repository_spec.rb

def reset_spaces_table
  seed_sql = File.read('spec/seeds.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'makersbnb_test' })
  connection.exec(seed_sql)
end

describe SpaceRepository do
  before(:each) do 
    reset_spaces_table
  end

  # (your tests will go here).
end
```

## 8. Test-drive and implement the Repository class behaviour

_After each test you write, follow the test-driving process of red, green, refactor to implement the behaviour._


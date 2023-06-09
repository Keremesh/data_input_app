# {{TABLE NAME}} Model and Repository Classes Design Recipe

_Copy this recipe template to design and implement Model and Repository classes for a database table._

## 1. Design and create the Table

If the table is already created in the database, you can skip this step.

Otherwise, [follow this recipe to design and create the SQL schema for your table](./single_table_design_recipe_template.md).

```

Table: admins

Columns:
id | username | password |
```

## 2. Create Test SQL seeds

Your tests will depend on data stored in PostgreSQL to run.

If seed data is provided (or you already created it), you can skip this step.

```sql
-- EXAMPLE
-- (file: spec/seeds_{table_name}.sql)

-- Write your SQL seed here. 

-- First, you'd need to truncate the table - this is so our table is emptied between each test run,
-- so we can start with a fresh state.
-- (RESTART IDENTITY resets the primary key)

TRUNCATE TABLE admins RESTART IDENTITY; -- replace with your own table name.

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO admins ("username", "password") VALUES
('Pepito_C', 'password'),

```

Run this SQL file on the database to truncate (empty) the table, and insert the seed data. Be mindful of the fact any existing records in the table will be deleted.

```bash
psql -h 127.0.0.1 makersbnb_test < spec/seeds.sql
```

## 3. Define the class names

Usually, the Model class name will be the capitalised table name (single instead of plural). The same name is then suffixed by `Repository` for the Repository class name.

```ruby
# EXAMPLE
# Table name: users

# Model class
# (in lib/users.rb)
class User
end

# Repository class
# (in lib/user_repository.rb)
class UserRepository
end
```

## 4. Implement the Model class

Define the attributes of your Model class. You can usually map the table columns to the attributes of the class, including primary and foreign keys.

```ruby
# Table name: users

# Model class
# (in lib/user.rb)

class User
  attr_accessor :id, :name, :email, :username, :password
end

```

## 5. Define the Repository Class interface

Your Repository class will need to implement methods for each "read" or "write" operation you'd like to run against the database.

Using comments, define the method signatures (arguments and return value) and what they do - write up the SQL queries that will be used by each method.

```ruby
# EXAMPLE
# Table name: users

# Repository class
# (in lib/user_repository.rb)

class UserRepository

  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    # SELECT id, name, email, username, password FROM users;

    # Returns an array of User objects.
  end

  # Gets a single record by its ID
  # One argument: the id (number)
  # def find(id)
  #   # Executes the SQL query:
  #   # SELECT id, name, cohort_name FROM students WHERE id = $1;

  #   # Returns a single Student object.
  # end

  # Add more methods below for each operation you'd like to implement.

  def create(user)
    # INSERT INTO users (name, email, username, password) VALUES ($1, $2, $3, $4);

    #returns new user
  end

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
# Get all users
repo = UserRepository.new

users = repo.all

users.length # =>  2
users[0].id # =>  1
users[0].name # =>  Pepito Callicott'
users[0].email # => 'pcallicott0@opensource.org'
users[0].username #=> 'pcallicott0'
users[0].password # =>  '$2a$12$7Bpme/Bdgwoi0BPZeDJcXOCvS7NrZy3PXZotXkFtFEge9k2Y0mCfa'

users[1].id # =>  2
users[1].name # =>  'Drugi Leverson'
users[1].email #=> 'dleverson1@cbsnews.com'
users[1].username #=> 'dleverson1'
users[1].password # =>  '$2a$12$jpoLZYPCL6tjCsIWGU3/8ePa3qz7nSMRvi8ZtsrFcWUb8SnmtbhsOx'

#2
#create a new user
repo = UserRepository.new
user = User.new
user.name = "Newlia Userson"
user.email = "omgitsanewemail@hmail.com"
user.username = "NewliaUsername"
user.password = '$2a$12$jpoLZYPCL6tjCsIWGU3/8ePa3qz7nSMRvb8SnmtbhsOf'

repo.create(user)

users = repo.all

users.length #=> 8
users.last.name #=> "Newlia Userson"


# 2
# Get a single student

# repo = StudentRepository.new

# student = repo.find(1)

# student.id # =>  1
# student.name # =>  'David'
# student.cohort_name # =>  'April 2022'

# # Add more examples for each method
# ```

Encode this example as a test.

## 7. Reload the SQL seeds before each test run

Running the SQL code present in the seed file will empty the table and re-insert the seed data.

This is so you get a fresh table contents every time you run the test suite.

```ruby
# EXAMPLE

# file: spec/student_repository_spec.rb

def reset_students_table
  seed_sql = File.read('spec/seeds_students.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'students' })
  connection.exec(seed_sql)
end

describe StudentRepository do
  before(:each) do 
    reset_students_table
  end

  # (your tests will go here).
end
```

## 8. Test-drive and implement the Repository class behaviour

_After each test you write, follow the test-driving process of red, green, refactor to implement the behaviour._


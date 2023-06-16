# {{TABLE NAME}} Model and Repository Classes Design Recipe

_Copy this recipe template to design and implement Model and Repository classes for a database table._

## 1. Design and create the Table

Tables designed in /database_recipe.md
and created in psql

```

| Table                | Columns          |
| --------------------- | ------------------  |
|  user/admin           | username | password | 
|  players              | player_username     | 
|  transaction          | timestamp | player_username | amount | admin |
```

## 2. Create Test SQL seeds

Seed data is designed in /database_recipe.md
and implemented in seeds.sql

```bash
psql -h 127.0.0.1 your_database_name < seeds_{table_name}.sql
```

## 3. Define the class names

Usually, the Model class name will be the capitalised table name (single instead of plural). The same name is then suffixed by `Repository` for the Repository class name.

```ruby

class Admin
end
class AdminRepository
end

class Player
end
class PlayerRepository
end

class Transaction
end
class TransactionRepository
end

```

## 4. Implement the Model class

Define the attributes of your Model class. You can usually map the table columns to the attributes of the class, including primary and foreign keys.

```ruby

class Admin
  attr_accessor :id, :username, :password
end

class Player
  attr_accessor :id, :username, :agent
end

class Transaction
  attr_accessor :id, :amount, :player_id, :date_created, :admin_id
end

```

## 5. Define the Repository Class interface

Your Repository class will need to implement methods for each "read" or "write" operation you'd like to run against the database.

Using comments, define the method signatures (arguments and return value) and what they do - write up the SQL queries that will be used by each method.

```ruby

class AdminRepository

  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    # SELECT id, username, password FROM admins;

    # Returns an array of Admin objects.
  end

  # Gets a single record by its ID
  # One argument: the id (number)
  def find(username)
    # Executes the SQL query:
    # SELECT username, password FROM admins WHERE username = $1;

    # Returns a single Student object.
  end

  def create(admin)
  # INSERT INTO admins(username, password) VALUES ($1, $2);
  end

  def update(admin)
# UPDATE [table name] SET [column_name] = [new_value], [other_column_name] = [other_new_value];
# UPDATE albums SET title = 'New title' WHERE date='16th of November 2020';
  end

  def delete(admin)
# DELETE FROM [table name] WHERE [conditions];
  end
end
```

## 6. Write Test Examples

Write Ruby code that defines the expected behaviour of the Repository class, following your design from the table written in step 5.

These examples will later be encoded as RSpec tests.

```ruby
# EXAMPLES

# 1
# Get all admins

repo = AdminRepository.new

admins = repo.all

admins.length # =>  2

admins[0].id # =>  1
admins[0].username # =>  'TestAdmin'
admins[0].password # =>  'admin'

admins[0].id # =>  2
admins[0].username # =>  'TestAdmin2'
admins[0].password # =>  'admin2'

# 2
# Get a single admin

repo = AdminRepository.new

admin = repo.find(1)

admin.id # =>  1
admin.username # =>  'TestAdmin'
admin.password # =>  'admin'

```

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
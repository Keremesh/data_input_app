# Data Entry App Multi-Class Planned Design Recipe

## 1. Describe the Problem

As a user, I want to be able to create a new (admin) account on this app with my name, username and password.

As a user, I want to be able to login using my username and password.

As a user, I want to be able to create new players with their username

As a user, I want to be able to select a player from a dropdown menu and input the ammount of credit/debit manualy, then submit. The data should also save the timestamp of this entry and the admin's name who made this entry into the database.

<!-- As a user, I want to be able to view a summary of the total amount owed or owed to each player, calculated based on their individual transactions, so that I can easily identify who needs to be chased for debts or who needs to be paid.

As a user, I want to be able to generate a report or statement for each player, showing their transaction history and the current balance, so that I can provide a detailed overview of their financial activities. 
As a user, I want to be able to search for a specific player by name or username, so that I can quickly locate and view their details and transactions.

As a user, I want to receive notifications or alerts when a player's balance reaches a certain threshold or when there are outstanding debts, so that I can take appropriate actions in a timely manner.

As an administrator, I want to have access to administrative features such as creating new players, updating player details, and generating reports for all players, so that I can manage the online poker room efficiently.

As an administrator, I want to ensure the security and privacy of user data, implementing proper authentication and authorization mechanisms to protect sensitive information.-->

## 2. Design the Class System

_Consider diagramming out the classes and their relationships. Take care to
focus on the details you see as important, not everything. The diagram below
uses asciiflow.com but you could also use excalidraw.com, draw.io, or miro.com_

```
┌────────────────────────────┐
│ Entries                    │
│                            │
│ - add(entry)               │
│ - all                      │
│ - search_by_title(keyword) │
│   => [entries...]          │
└───────────┬────────────────┘
            │
            │ owns a list of
            ▼
┌─────────────────────────┐
│ Entry(player, amount)   │
│                         │
│ - player                │
│ - amount                │
│ - format                │
│   => "paid/received     |
| AMOUNT to/from PLAYER"  │
└─────────────────────────┘
```

_Also design the interface of each class in more detail._

```ruby
class AllEntries
  def initialize
    # ...
  end

  def add(entry) # track is an instance of Track
    # Track gets added to the library
    # Returns nothing
  end

  def all
    # Returns a list of track objects
  end
  
  def search_by_title(keyword) # keyword is a string
    # Returns a list of tracks with titles that include the keyword
  end
end

class Entry
  def initialize(player, amount) # title and artist are both strings
  end

  def format
    # Returns a string of the form "TITLE by ARTIST"
  end
end
```

## 3. Create Examples as Integration Tests

_Create examples of the classes being used together in different situations and
combinations that reflect the ways in which the system will be used._

```ruby
# EXAMPLE

# Gets all tracks
entries = AllEntries.new
entry_1 = Entry.new("player_1", 100)
entry_2 = Entry.new("player_2", 200)
entries.add(entry_1)
entries.add(entry_2)
entries.all # => [entry_1, entry_2]
```

## 4. Create Examples as Unit Tests

_Create examples, where appropriate, of the behaviour of each relevant class at
a more granular level of detail._

```ruby
# EXAMPLE

# Constructs an entry
entry = Entry.new("player_1", 100)
entry.player # => "player_1"
entry.amount # => 100
```

_Encode each example as a test. You can add to the above list as you go._

## 5. Implement the Behaviour

_After each test you write, follow the test-driving process of red, green,
refactor to implement the behaviour._


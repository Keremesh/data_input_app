# Multi Table Design Recipe Template

_Copy this recipe template to design and create two related database tables from a specification._

## 1. Extract nouns from the user stories or specification

```

As a user, I want to be able to sign up as an admin to the app.

As a user, I want to be able to create new players/player accounts

As a user, I want to be able to select a player and input the ammount of credit/debit manualy, then submit. 

As a user, I want to see the list with all "transactions" containing player username, amount, timestamp and admin name.  

As a user I should only be able to edit ammounts of existing players


```
Nouns:
user, player, app, amount, timestamp, admin. 
```

## 2. Infer the Table Name and Columns

Put the different nouns in this table. Replace the example with your own nouns.

| Record                | Properties          |
| --------------------- | ------------------  |
|  user/admin           | username | password | 
|  players              | player_username     | 
|  transaction          | timestamp | player_username | amount | admin |

## 3. Decide the column types.

[Here's a full documentation of PostgreSQL data types](https://www.postgresql.org/docs/current/datatype.html).

Most of the time, you'll need either `text`, `int`, `bigint`, `numeric`, or `boolean`. If you're in doubt, do some research or ask your peers.

Remember to **always** have the primary key `id` as a first column. Its type will always be `SERIAL`.

```
# EXAMPLE:

Table: admins
id: SERIAL
username: varchar UNIQUE
password: varchar
<!-- 
email: varchar UNIQUE
name: text -->

Table: players
id: SERIAL
username: varchar UNIQUE
agent: text

Table: transaction
id: SERIAL
amount: money
player_id: int
timestamp: now
admin_id: int

```

## 4. Decide on The Tables Relationship

```
# EXAMPLE

1. Admins can have many transactions and players <!-- (foreign keys in transactions, players) -->
2. Players belongs to admins. Players can have many transactions
3. Transaction belongs to admin and player

-> Therefore, the foreign keys are on player and transaction tables.


## 4. Write the SQL.

```sql
-- EXAMPLE
-- file: users_table.sql

-- Create the table without the foreign key first.
CREATE TABLE admin (
  id SERIAL PRIMARY KEY,
  username varchar UNIQUE,
  password varchar
  
);

CREATE TABLE players (
id SERIAL PRIMARY KEY,
username varchar UNIQUE,
agent text
)

CREATE TABLE transaction (
id SERIAL PRIMARY KEY,
amount money,
player_id int,
date_created timestamp,
admin_id: int,
CONSTRAINT fk_player FOREIGN KEY(player_id)
      REFERENCES players(id)
      ON DELETE CASCADE,
  CONSTRAINT fk_admin FOREIGN KEY(admin_id)
      REFERENCES admins(id)
      ON DELETE CASCADE
);

```

## 5. Create the tables.

```bash
psql -h 127.0.0.1 puts_it < app_tables.sql
```


CREATE TABLE IF NOT EXISTS admins (
  id SERIAL PRIMARY KEY,
  username varchar UNIQUE,
  password varchar
);

CREATE TABLE IF NOT EXISTS players (
id SERIAL PRIMARY KEY,
username varchar UNIQUE,
agent text
);

CREATE TABLE IF NOT EXISTS transactions (
id SERIAL PRIMARY KEY,
amount money,
player_id int,
date_created timestamp,
admin_id int,
CONSTRAINT fk_player FOREIGN KEY(player_id)
      REFERENCES players(id)
      ON DELETE CASCADE,
  CONSTRAINT fk_admin FOREIGN KEY(admin_id)
      REFERENCES admins(id)
      ON DELETE CASCADE
);
TRUNCATE TABLE admins, players, transactions RESTART IDENTITY;

INSERT INTO admins ("username", "password") VALUES ('TestAdmin', '$2a$12$FiILcMtM1ndfnBeW0sAy.uooRAt1w5kKefZILfPOrFCvfYyf8FUNG'); -- admin
INSERT INTO admins ("username", "password") VALUES ('TestAdmin2', 'admin2');

INSERT INTO players ("username", "agent") VALUES ('TestPlayer', 'TestAgent');
INSERT INTO players ("username", "agent") VALUES ('TestPlayer2', 'TestAgent2');

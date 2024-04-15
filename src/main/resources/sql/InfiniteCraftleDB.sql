CREATE TABLE Element (
  element_id INT PRIMARY KEY,
  name VARCHAR(255),
  emoji VARCHAR(255)
);

CREATE TABLE ElementsCrafted (
  parent1_id INT,
  parent2_id INT,
  child_id INT,
  PRIMARY KEY (parent1_id, parent2_id),
  FOREIGN KEY (parent1_id) REFERENCES Element(element_id),
  FOREIGN KEY (parent2_id) REFERENCES Element(element_id),
  FOREIGN KEY (child_id) REFERENCES Element(element_id)
);

CREATE TABLE LastGames (
  date DATE PRIMARY KEY,
  element_id INT,
  FOREIGN KEY (element_id) REFERENCES Element(element_id)
);

CREATE TABLE User (
  user_id INT PRIMARY KEY,
  username VARCHAR(255),
  password_salt VARCHAR(16), -- For bcrypt, 16 bytes (128 bits)
  password_hash VARCHAR(60) -- For bcrypt, typically 60 characters
);

CREATE TABLE GameInstance (
  date DATE,
  user_id INT,
  score INT,
  time DOUBLE,
  past_game BOOLEAN,
  PRIMARY KEY (date, user_id),
  FOREIGN KEY (user_id) REFERENCES User(user_id),
  FOREIGN KEY (date) REFERENCES LastGames(date)
);

CREATE TABLE CraftedInGame (
  date DATE, 
  user_id INT,
  element_id INT,
  PRIMARY KEY (date, user_id, element_id),
  FOREIGN KEY (date, user_id) REFERENCES GameInstance(date, user_id),
  FOREIGN KEY (element_id) REFERENCES Element(element_id)
);
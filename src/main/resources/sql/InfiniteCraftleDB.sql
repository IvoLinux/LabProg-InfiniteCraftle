CREATE TABLE Element (
  element_id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(255),
  emoji VARCHAR(255),
  depth INT
);

CREATE TABLE ElementsCrafted (
  parent1_id INT,
  parent2_id INT,
  child_id INT,
  PRIMARY KEY (parent1_id, parent2_id),
  FOREIGN KEY (parent1_id) REFERENCES Element(element_id) ON DELETE CASCADE,
  FOREIGN KEY (parent2_id) REFERENCES Element(element_id) ON DELETE CASCADE,
  FOREIGN KEY (child_id) REFERENCES Element(element_id) ON DELETE CASCADE
);

CREATE TABLE LastGames (
  date DATE PRIMARY KEY,
  element_id INT,
  FOREIGN KEY (element_id) REFERENCES Element(element_id) ON DELETE CASCADE
);

CREATE TABLE User (
  user_id INT AUTO_INCREMENT PRIMARY KEY,
  username VARCHAR(255),
  password_hash VARCHAR(60)
);

CREATE TABLE GameInstance (
  date DATE,
  user_id INT,
  score INT,
  time INT,
  win BOOLEAN,
  PRIMARY KEY (date, user_id),
  FOREIGN KEY (user_id) REFERENCES User(user_id) ON DELETE CASCADE,
  FOREIGN KEY (date) REFERENCES LastGames(date) ON DELETE CASCADE
);

CREATE TABLE CraftedInGame (
  date DATE, 
  user_id INT,
  element_id INT,
  PRIMARY KEY (date, user_id, element_id),
  FOREIGN KEY (date, user_id) REFERENCES GameInstance(date, user_id) ON DELETE CASCADE,
  FOREIGN KEY (element_id) REFERENCES Element(element_id) ON DELETE CASCADE
);

INSERT INTO Element(name, emoji, depth) VALUES ('water', '💧', '0');
INSERT INTO Element(name, emoji, depth) VALUES ('fire', '🔥', '0');
INSERT INTO Element(name, emoji, depth) VALUES ('earth', '🌍', '0');
INSERT INTO Element(name, emoji, depth) VALUES ('wind', '💨', '0');
INSERT INTO Element(name, emoji, depth) VALUES ('steam', '💨', '1');
INSERT INTO ElementsCrafted(parent1_id, parent2_id, child_id) VALUES ('1', '2', '5');

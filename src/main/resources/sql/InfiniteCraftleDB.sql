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
  password_hash VARCHAR(60) -- For bcrypt, typically 60 characters
);

CREATE TABLE GameInstance (
  date DATE,
  user_id INT,
  score INT,
  time DOUBLE,
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
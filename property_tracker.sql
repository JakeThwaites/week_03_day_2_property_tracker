DROP TABLE IF EXISTS property_tracker;

CREATE TABLE property_tracker (
  id SERIAL8 PRIMARY KEY,
  value INT,
  number_of_bedrooms INT,
  year_built INT,
  buy_let_status VARCHAR(255)
);

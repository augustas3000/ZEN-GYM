
DROP TABLE class_bookings;
DROP TABLE gym_classes;
DROP TABLE gym_activities;
DROP TABLE gym_members;

CREATE TABLE gym_members
(
  id SERIAL PRIMARY KEY,
  member_name VARCHAR(255) NOT NULL,
  member_surname VARCHAR(255) NOT NULL,
  membership_status VARCHAR(255) NOT NULL,
  member_activation_status VARCHAR(255) NOT NULL
);

CREATE TABLE gym_activities
(
  id SERIAL PRIMARY KEY,
  activity_name VARCHAR(255) NOT NULL
);

CREATE TABLE gym_classes
(
  id SERIAL PRIMARY KEY,
  activity_id INT references gym_activities(id) ON DELETE CASCADE,
  class_time  TIME,
  class_capacity INT,
  class_activation_status VARCHAR(255) NOT NULL
);

CREATE TABLE class_bookings
(
  id SERIAL PRIMARY KEY,
  gym_member_id INT references gym_members(id) ON DELETE CASCADE,
  gym_class_id INT references gym_classes(id) ON DELETE CASCADE
);















--

.read su19data.sql

CREATE TABLE obedience AS
  SELECT seven, instructor FROM students;

CREATE TABLE smallest_int AS
  SELECT time, smallest FROM students WHERE smallest > 2 ORDER BY smallest LIMIT 20;

CREATE TABLE matchmaker AS
  SELECT first.pet, first.song, first.color, second.color FROM students as first, students as second
  WHERE first.time < second.time AND first.pet = second.pet AND first.song = second.song;

CREATE TABLE smallest_int_having AS
  SELECT time, smallest FROM students
  GROUP BY smallest HAVING (count(*) = 1);

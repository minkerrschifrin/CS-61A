CREATE TABLE parents AS
  SELECT "abraham" AS parent, "barack" AS child UNION
  SELECT "abraham"          , "clinton"         UNION
  SELECT "delano"           , "herbert"         UNION
  SELECT "fillmore"         , "abraham"         UNION
  SELECT "fillmore"         , "delano"          UNION
  SELECT "fillmore"         , "grover"          UNION
  SELECT "eisenhower"       , "fillmore";

CREATE TABLE dogs AS
  SELECT "abraham" AS name, "long" AS fur, 26 AS height UNION
  SELECT "barack"         , "short"      , 52           UNION
  SELECT "clinton"        , "long"       , 47           UNION
  SELECT "delano"         , "long"       , 46           UNION
  SELECT "eisenhower"     , "short"      , 35           UNION
  SELECT "fillmore"       , "curly"      , 32           UNION
  SELECT "grover"         , "short"      , 28           UNION
  SELECT "herbert"        , "curly"      , 31;

CREATE TABLE sizes AS
  SELECT "toy" AS size, 24 AS min, 28 AS max UNION
  SELECT "mini"       , 28       , 35        UNION
  SELECT "medium"     , 35       , 45        UNION
  SELECT "standard"   , 45       , 60;

-------------------------------------------------------------
-- PLEASE DO NOT CHANGE ANY SQL STATEMENTS ABOVE THIS LINE --
-------------------------------------------------------------

-- The size of each dog
CREATE TABLE size_of_dogs AS
  SELECT name, size FROM dogs, sizes WHERE min < height AND height <= max;
  -- below also works:
  -- SELECT d.name, s.size FROM dogs as d, sizes as s
  -- WHERE s.min < d.height AND d.height <= s.max;

-- All dogs with parents ordered by decreasing height of their parent
CREATE TABLE by_parent_height AS
  SELECT p.child FROM parents AS p, dogs AS d
  WHERE p.parent = d.name ORDER BY d.height DESC;

-- Filling out this helper table is optional
CREATE TABLE siblings AS
  SELECT "REPLACE THIS LINE WITH YOUR SOLUTION";
  -- a.child AS sibling1, b.child AS sibling2 FROM parents AS a, parents AS b
  -- WHERE a.parent = b.parent AND sibling1 < sibling2;

-- Sentences about siblings that are the same size
CREATE TABLE sentences AS
  SELECT a.name || " and " || b.name || " are " || b.size || " siblings"
  FROM size_of_dogs AS a, size_of_dogs AS b, parents as x, parents as y
  WHERE a.size = b.size AND x.parent = y.parent AND x.child = a.name AND y.child = b.name
  AND a.name != b.name AND a.name < b.name
  ORDER BY a.name;

-- Total size for each fur type where all of the heights differ by no more than 30% from the average height
CREATE TABLE low_variance AS
  SELECT fur, SUM(height) FROM dogs GROUP BY fur HAVING MIN(height) > (AVG(height) - (.3 * AVG(height)))
  AND (AVG(height) + (.3 * AVG(height))) > MAX(height);

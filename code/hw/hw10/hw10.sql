CREATE TABLE parents AS
  SELECT "ace" AS parent, "bella" AS child UNION
  SELECT "ace"          , "charlie"        UNION
  SELECT "daisy"        , "hank"           UNION
  SELECT "finn"         , "ace"            UNION
  SELECT "finn"         , "daisy"          UNION
  SELECT "finn"         , "ginger"         UNION
  SELECT "ellie"        , "finn";

CREATE TABLE dogs AS
  SELECT "ace" AS name, "long" AS fur, 26 AS height UNION
  SELECT "bella"      , "short"      , 52           UNION
  SELECT "charlie"    , "long"       , 47           UNION
  SELECT "daisy"      , "long"       , 46           UNION
  SELECT "ellie"      , "short"      , 35           UNION
  SELECT "finn"       , "curly"      , 32           UNION
  SELECT "ginger"     , "short"      , 28           UNION
  SELECT "hank"       , "curly"      , 31;

CREATE TABLE sizes AS
  SELECT "toy" AS size, 24 AS min, 28 AS max UNION
  SELECT "mini"       , 28       , 35        UNION
  SELECT "medium"     , 35       , 45        UNION
  SELECT "standard"   , 45       , 60;


-- All dogs with parents ordered by decreasing height of their parent
CREATE TABLE by_parent_height AS
  SELECT
    p.child
  FROM parents p
  JOIN dogs d ON p.parent = d.name
  ORDER BY d.height DESC;


-- The size of each dog
CREATE TABLE size_of_dogs AS
  SELECT d.name, s.size FROM dogs d JOIN sizes s ON d.height > s.min AND d.height <= s.max;


-- [Optional] Filling out this helper table is recommended
CREATE TABLE siblings AS
  SELECT p1.child AS sibling1, p2.child AS sibling2
  FROM parents p1
  JOIN parents p2 ON p1.parent = p2.parent AND p1.child <> p2.child AND p1.child < p2.child;

-- Sentences about siblings that are the same size
CREATE TABLE sentences AS
  SELECT "The two siblings, " || sibling1 || " and " || sibling2 || ", have the same size: " || sz1.size
  FROM siblings s
  JOIN size_of_dogs sz1 ON s.sibling1 = sz1.name
  JOIN size_of_dogs sz2 ON s.sibling2 = sz2.name
  WHERE sz1.size = sz2.size;


-- Height range for each fur type where all of the heights differ by no more than 30% from the average height
CREATE TABLE low_variance AS
SELECT
  fur,
  MAX(height) - MIN(height) AS height_range
FROM dogs
GROUP BY fur
HAVING
  MIN(height) >= AVG(height) * 0.7 AND
  MAX(height) <= AVG(height) * 1.3;


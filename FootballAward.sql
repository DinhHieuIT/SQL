CREATE TABLE footballer (
id int PRIMARY KEY NOT NULL auto_increment,
name varchar(50),
team varchar(50),
soccer int(2)
)

DELIMITER $$
CREATE FUNCTION foolballlerAward( 
soccerInYear int(2)
)
RETURNS varchar(50)
DETERMINISTIC
BEGIN
  DECLARE award varchar(50);
  if soccerInYear<30 THEN SET award ="Aluminum";
  ELSEIF (soccerInYear > 30 AND soccerInYear <40) THEN SET  award ="Silver";
  ELSEIF (soccerInYear >40) THEN SET  award ="Golden";
  END IF;
  RETURN (award);
END$$
DELIMITER $$

SHOW FUNCTION STATUS WHERE db = "function"

SELECT name, foolballlerAward(soccer) as Award FROM footballer ORDER BY name;

DELIMITER $$
CREATE PROCEDURE AwardList()
BEGIN 
SELECT name, foolballlerAward(soccer) as Award FROM footballer ORDER BY name;
END$$
DELIMITER $$

CALL AwardList()
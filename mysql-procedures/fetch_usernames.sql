delimiter //

CREATE PROCEDURE fetch_usernames(IN n INT(20), IN offset INT(20))
BEGIN
  SELECT
    username
  FROM
    account 
  LIMIT offset, n;
END//

delimiter ;


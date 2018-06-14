delimiter //

CREATE PROCEDURE fetch_cars(IN n INT(20), IN offset INT(20))
BEGIN
  SELECT
    *
  FROM
    car
  LIMIT offset, n;
END//

delimiter ;


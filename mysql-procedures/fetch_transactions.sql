delimiter //

CREATE PROCEDURE fetch_transactions(IN n INT(20), IN offset INT(20))
BEGIN
  SELECT
    username,
    execution_date,
    brand,
    model,
    year,
    mileage,
    price,
    img
  FROM
    transaction t
    JOIN car c ON t.car_id=c.id
    JOIN account a ON t.account_id=a.id
  ORDER BY execution_date ASC
  LIMIT offset, n;
END//

delimiter ;


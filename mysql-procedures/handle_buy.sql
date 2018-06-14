miter // CREATE PROCEDURE handle_buy (IN id_account INT, IN id_car INT)
BEGIN

DECLARE card_id_var INT ;
DECLARE balance_var INT;
DECLARE car_price INT;
DECLARE new_balance INT;

SELECT
   card_id INTO card_id_var 
FROM
   account 
WHERE
   id = id_account;

SELECT
   balance INTO balance_var 
FROM
   card 
WHERE
   id = card_id_var;

SELECT
   price INTO car_price 
FROM
   car 
WHERE
   id = id_car ;

SET
   new_balance = balance_var - car_price;
UPDATE
   card 
SET
   balance = new_balance 
WHERE
   id = card_id_var;

INSERT INTO
   transaction(account_id, car_id, execution_date) 
VALUES
   (
      id_account,
      id_car,
      CURDATE()
   )
;

UPDATE
   car 
SET
   status = 'sold_out' 
WHERE
   id = id_car;

END//

delimiter ;

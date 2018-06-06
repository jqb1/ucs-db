CREATE PROCEDURE buyCar(IN id_account INT, IN id_car INT)
BEGIN
UPDATE card
SET balance=(SELECT price FROM car where id=id_car);
INSERT INTO transaction(account_id, car_id, execution_date)
VALUES(id_account, id_car,CURDATE());
UPDATE car
SET status='sold_out'
WHERE id=id_car;
END;


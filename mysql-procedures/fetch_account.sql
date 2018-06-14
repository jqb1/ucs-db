delimiter //

CREATE PROCEDURE fetch_account(IN usernamee VARCHAR(20))
BEGIN
   SELECT
      a.id,
      username,
      password,
      privilege,
      balance,
      creation_date,
      last_visit,
      name,
      surname,
      email,
      phone,
      number AS card_number
   FROM
      account a
      JOIN
         card c
         ON a.card_id = c.id
      JOIN
         person p
         ON a.person_id = p.id
   WHERE
      username = usernamee;
END//

delimiter ;


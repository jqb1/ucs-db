## used cars online // database

| Entity      | Attributes                                                              |
| ----------- | ----------------------------------------------------------------------- |
| person      | id, name, surname, email, address                                       |
| account     | id, person_id, card_id, username, password, creation_date, last_visit   |
| card        | id, number, expenses                                                    |
| transaction | id, account_id, car_id, execution_date                                  |
| car         | id, brand, model, mileage, production_year, price                       |


### relations

**1** (rhs) **to many** (lhs):
- account.person_id       ->  person.id
- transaction.account_id  ->  account.id

**1 to 1**:
- account.card_id         ->  card.id
- transaction.car_id      ->  car.id 


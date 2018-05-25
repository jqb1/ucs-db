import MySQLdb.cursors


def validate_user(db_handle, username, password):
  query = ("SELECT EXISTS(SELECT 1 FROM account " +
           "WHERE username='{}' AND password='{}')".format(username, password))

  cursor = db_handle.query(query)
  out = cursor.fetchone()

  return out[0] != 0


def fetch_user(db_handle, username):
  query = ("SELECT * FROM account " +
           "JOIN card ON account.card_id=card.id " +
           "WHERE username='{}'".format(username))

  cursor = db_handle.query(query, cursor_type=MySQLdb.cursors.DictCursor)
  out = cursor.fetchone()

  return out


def fetch_cars(db_handle, filter=None):
  query = ["SELECT * FROM car"]

  if filter != None:
    conditions = []

    for key, value, operator in filter:
      conditions.append("{}{}'{}'"
                        .format(key, operator, value))

    query.append("WHERE")
    query.append(' AND '.join(conditions))

  cursor = db_handle.query(
      ' '.join(query), cursor_type=MySQLdb.cursors.DictCursor)
  out = cursor.fetchall()

  return out

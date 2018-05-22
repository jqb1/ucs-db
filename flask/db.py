import MySQLdb
import time
import sys

def connect(username, password, host="database", db="used_cars_store", counter=5):
  try:
    handle = MySQLdb.connect(host=host, user=username, passwd=password, db=db)
  except:
    if counter > 0:
      print("MySQLdb.connect failed. Reconnecting after a while..", file=sys.stderr)
      time.sleep(5)
      handle = connect(username, password, host, db, counter - 1)
    else:
      exit(1)
  return handle


def validate_user(db, username, password):
  cursor = db.cursor()

  query = ("SELECT EXISTS(SELECT 1 FROM account WHERE " +
           "username='{}' AND password='{}')".format(username, password))
  cursor.execute(query)

  out = cursor.fetchone()

  return out[0] != 0


def fetch_user(db, username):
  cursor = db.cursor(MySQLdb.cursors.DictCursor)
  
  query = ("SELECT * FROM account " +
           "JOIN card ON account.card_id=card.id " +
           "WHERE username='{}'".format(username))
  
  cursor.execute(query)
  out = cursor.fetchone()

  return out

def fetch_cars(db, filter=None):
  cursor = db.cursor(MySQLdb.cursors.DictCursor)

  query = ["SELECT * FROM car"]

  if filter != None:
    conditions = []

    for key, value, operator in filter:
      conditions.append("{}{}'{}'"
        .format(key, operator, value))

    query.append("WHERE")
    query.append(' AND '.join(conditions))

  cursor.execute(' '.join(query))

  out=cursor.fetchall()

  return out


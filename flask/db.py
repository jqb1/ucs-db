import MySQLdb

def connect_to_db(username, password):
  return MySQLdb.connect(host="35.176.206.50", user=username, passwd=password, db="used_cars_store")

def validate_user(db, username, password):
  cursor = db.cursor()
  cursor.execute("SELECT EXISTS(SELECT 1 FROM account WHERE username='{}' AND password='{}')".format(username, password))
  return cursor.fetchone()[0] != 0


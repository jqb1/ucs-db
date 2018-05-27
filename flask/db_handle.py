import MySQLdb


class DB:

  conn = None
  
  def __init__(self, username, password, 
    database, hostname="localhost", port=3306):
    self.username = username
    self.password = password
    self.database = database
    self.hostname = hostname
    self.port = port

  def connect(self):
    self.conn = MySQLdb.connect(user=self.username, 
      passwd=self.password, db=self.database, host=self.hostname)

  def query(self, sql):
    try:
      cursor = self.conn.cursor(MySQLdb.cursors.DictCursor)
      cursor.execute(sql)
    except (AttributeError, MySQLdb.OperationalError):
      self.connect()
      cursor = self.conn.cursor(MySQLdb.cursors.DictCursor)
      cursor.execute(sql)
    return cursor


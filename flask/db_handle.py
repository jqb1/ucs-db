import MySQLdb


class DBHandle:
  """ Correct way of keeping MySQL connection.
      Prevents MySQL server gone away issue.

      Base copied and pasted from stackoverflow. """

  conn = None
  
  def __init__(self, username, password, database, hostname="localhost", port=3306):
    self.username = username
    self.password = password
    self.database = database
    self.hostname = hostname
    self.port = port

  def connect(self):
    self.conn = MySQLdb.connect(user=self.username, passwd=self.password,
                                db=self.database, host=self.hostname)

  def query(self, sql, cursor_type=None):
    try:
      cursor = self.conn.cursor(cursor_type) if cursor_type else self.conn.cursor()
      cursor.execute(sql)
    except (AttributeError, MySQLdb.OperationalError):
      self.connect()
      cursor = self.conn.cursor(cursor_type) if cursor_type else self.conn.cursor()
      cursor.execute(sql)
    return cursor

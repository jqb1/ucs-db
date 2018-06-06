from mysql_fetch import \
  fetch_no_rows
from math import \
  ceil

def pagination(db, page, n, table):
  no_rows = fetch_no_rows(db, table)
  max_page = ceil(no_rows / n) + 1
  offset = (page - 1) * n
  return (max_page, offset)



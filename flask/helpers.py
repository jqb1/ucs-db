from mysql_fetch import \
  fetch_no_rows, count_with_filter
from math import \
  ceil

def pagination(db, page, n, table):
  no_rows = fetch_no_rows(db, table)
  max_page = ceil(no_rows / n) + 1
  offset = (page - 1) * n
  return (max_page, offset)


def count_cars(db,n,filter=None):
    count=count_with_filter(db,filter)
    max_page = ceil(count / n) +1
    return max_page
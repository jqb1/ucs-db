from mysql_fetch import \
    fetch_no_rows, \
    count_cars
from math import \
    ceil


def pagination(db, page, n, table):
    no_rows = fetch_no_rows(db, table)
    max_page = ceil(no_rows / n) + 1
    offset = (page - 1) * n
    return (max_page, offset)


def pagination_with_filter(db, page, n, filter):
    cars_num = count_cars(db, filter)
    max_page = ceil(cars_num / n) + 1
    offset = (page - 1) * n
    return (max_page, offset)

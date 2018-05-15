import db


def main():
  database = db.connect("koziol", "admin1")

  filter = [('brand', 'Ford', '='),
    ('mileage', '150000', '<')]

  for i in db.fetch_cars(database, filter):
    print(i)


if __name__ == '__main__':
  main()


import db


def get_cars(brand):
    database = db.connect("koziol", "admin1")

    filter = [('brand', brand, '=')]
    if brand is not None:
        cars = db.fetch_cars(database, filter)
    else:
        cars = db.fetch_cars(database)


    return cars

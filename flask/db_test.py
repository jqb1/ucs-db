import db


def get_cars(brand):
    database = db.connect("root", "bazdan#20", host='35.176.188.105')

    filter = [('brand', brand, '=')]
    if brand is not None:
        cars = db.fetch_cars(database, filter)
    else:
        cars = db.fetch_cars(database)

    return cars

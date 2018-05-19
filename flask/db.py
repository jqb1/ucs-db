import MySQLdb



def connect(username, password, host="52.56.98.154", db="used_cars_store"):
    return MySQLdb.connect( \
        host=host, \
        user=username, \
        passwd=password, \
        db=db)


def validate_user(db, username, password):
    cursor = db.cursor()

    query = ("SELECT EXISTS(SELECT 1 FROM account WHERE " +
             "username='{}' AND password='{}')".format(username, password))
    cursor.execute(query)

    out = cursor.fetchone()

    return out[0] != 0


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

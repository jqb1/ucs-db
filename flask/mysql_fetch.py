def fetch_account(db, username, verbose=False):
    columns = None

    if verbose:
        columns = ['username',
                   'password',
                   'privilege',
                   'balance',
                   'creation_date',
                   'last_visit',
                   'name',
                   'surname',
                   'email',
                   'phone',
                   'number AS card_number']
    else:
        columns = ['username',
                   'password',
                   'privilege',
                   'balance']

    query = ('SELECT {} FROM account a '
             'JOIN card c ON a.card_id=c.id '
             'JOIN person p ON a.person_id=p.id '
             "WHERE username='{}'"
             .format(', '.join(columns), username))

    return db.query(query).fetchone()


def fetch_usernames(db, n, offset):
    query = ('SELECT username FROM account '
             'LIMIT {},{}'.format(offset, n))

    ugly_tuple = db.query(query).fetchall()
    return [x['username'] for x in ugly_tuple]


def fetch_transactions(db, n, offset, desc=False):
    columns = ['username',
               'execution_date',
               'brand',
               'model',
               'year',
               'mileage',
               'price',
               'img']

    mode = 'ASC' if not desc else 'DESC'

    query = ('SELECT {} FROM transaction t '
             'JOIN car c ON t.car_id=c.id '
             'JOIN account a ON t.account_id=a.id '
             'ORDER BY execution_date {} '
             'LIMIT {},{}'
             .format(', '.join(columns), mode, offset, n))

    print(query)

    return db.query(query).fetchall()


def fetch_no_rows(db, table):
    query = ('SELECT COUNT(*) AS n '
             'FROM {}'.format(table))

    return db.query(query).fetchone()['n']


def fetch_column(db, column,table):
    query = "SELECT {} FROM {}".format(column, table)
    out = db.query(query).fetchall()
    values=[]
    for i in out:
        values.append(i[column])

    return values

def fetch_cars(db,start_at,per_page, filter=None):


  query = ["SELECT * FROM car "]

  if filter != None:
    conditions = []

    for key, value, operator in filter:
      conditions.append("{}{}'{}'"
        .format(key, operator, value))

    query.append("WHERE")
    query.append(' AND '.join(conditions))

  query.append("LIMIT {},{}".format(start_at,per_page))

  return db.query(' '.join(query)).fetchall()


from flask import \
    Flask, \
    redirect, \
    url_for, \
    render_template, \
    request, \
    session
from db_handle import \
    DB

from helpers import \
    pagination,\
    pagination_with_filter
from mysql_fetch import \
    fetch_account, \
    fetch_usernames, \
    fetch_transactions, \
    fetch_cars, \
    fetch_column

app = Flask(__name__)
db = DB(username='root',
        password='bazdan#20',
        database='used_cars_store',
        hostname='35.176.188.105')
app.secret_key = \
    b'\xd7\xedc\xe0Rh|R\xe5Z\x82\xc1w\x00\xfe%'

# global variable for
current_filtration = []


@app.route('/')
def home():
    return redirect(url_for('login'))


@app.route('/login')
def login():
    if 'account' in session:
        return redirect(url_for('store'))
    else:
        return render_template('login.html')


@app.route("/store", defaults={'page': 1}, methods=['GET', 'POST'])
@app.route("/store/<int:page>", methods=['GET', 'POST'])
def store(page):
    if 'account' in session:

        brands = fetch_column(db, 'brand', 'car')

        brands_unique = set(brands)

        if request.method == 'POST':

            current_filtration.clear()

            brand = request.form['brand']
            year = request.form['year']
            min_price = request.form['minprice']
            max_price = request.form['maxprice']

            filter = [('price', min_price, '>='), ('price', max_price, '<='), ('year', year, '>='),
                      ('brand', brand, '=')]

            for condition in filter:
                # if form field is not empty
                if condition[1] != '':
                    current_filtration.append(condition)

            if len(current_filtration) != 0:
                return redirect(url_for('store_detail'))
            else:
                return redirect(url_for('store'))

        if request.method == 'GET':
            current_filtration.clear()

            results_per_page = 3
            start_at = (page - 1) * results_per_page
            cars = fetch_cars(db, start_at, results_per_page)
            if len(cars) == 0:
                page = -1
            if page + 1 == 0:
                page = 0
            return render_template('store.html', cars=cars, brands=brands_unique, account=session['account'],
                                   page=page + 1)

    else:
        return redirect(url_for('login'))


@app.route('/store/detail', defaults={'page': 1}, methods=['GET'])
@app.route('/store/detail/<int:page>', methods=['GET'])
def store_detail(page):
    if request.method == 'GET':
        brands = fetch_column(db, 'brand', 'car')
        brands_unique = set(brands)

        results_per_page = 3
        start_at = (page - 1) * results_per_page

        if len(current_filtration) == 0:
            return redirect(url_for('store'))

        else:
            cars = fetch_cars(db, start_at, results_per_page, current_filtration)
            if len(cars) == 0:
                page = -1
        if page + 1 == 0:
            page = 0
        return render_template('store_detail.html', cars=cars, brands=brands_unique, account=session['account'],
                               page=page + 1)


@app.route('/admin')
def admin():
    if 'account' in session:
        if session['account']['privilege'] == 'admin':
            return render_template('admin.html',
                                   account=session['account'])
        else:
            return redirect(url_for('store'))
    else:
        return redirect(url_for('login'))


@app.route('/admin/users')
def users():
    if 'account' in session:
        if session['account']['privilege'] == 'admin':
            args = request.args.to_dict()
            username = \
                str(args['username']) if 'username' in args else None
            page = int(args['page']) if 'page' in args else 1
            max_entries = 10
            max_page, offset = pagination(db, page,
                                          max_entries, table='account')
            usernames = fetch_usernames(db, max_entries, offset)
            account = fetch_account(db, username, verbose=True)
            return render_template('users.html',
                                   account=session['account'],
                                   usernames=usernames,
                                   page=page,
                                   pages=range(1, max_page),
                                   account_info=account)
        else:
            return redirect(url_for('store'))
    else:
        return redirect(url_for('login'))


@app.route('/admin/activity')
def activity():
    if 'account' in session:
        if session['account']['privilege'] == 'admin':
            args = request.args.to_dict()
            page = int(args['page']) if 'page' in args else 1
            max_entries = 3
            max_page, offset = pagination(db, page,
                                          max_entries, table='transaction')
            transactions = fetch_transactions(db,
                                              max_entries, offset)
            return render_template('activity.html',
                                   account=session['account'],
                                   transactions=transactions,
                                   page=page,
                                   pages=range(1, max_page))
        else:
            return redirect(url_for('store'))
    else:
        return redirect(url_for('login'))


@app.route('/logout')
def logout():
    session.pop('account', None)
    return redirect(url_for('login'))


@app.route('/validate', methods=['POST'])
def validate():
    username = request.form['username']
    password = request.form['password']
    account = fetch_account(db, username)
    if account and account['password'] == password:
        session['account'] = account
        return redirect(url_for('store'))
    else:
        return redirect(url_for('login'))


if __name__ == '__main__':
    app.run(host='localhost', port='5000', debug=True)

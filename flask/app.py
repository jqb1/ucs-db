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
  pagination
from mysql_fetch import \
  fetch_account, \
  fetch_usernames, \
  fetch_transactions, \
  fetch_cars


app = Flask(__name__)
db = DB(username='root', 
  password='bazdan#20',
  database='used_cars_store', 
  hostname='35.176.188.105')
app.secret_key = \
  b'\xd7\xedc\xe0Rh|R\xe5Z\x82\xc1w\x00\xfe%'


@app.route('/')
def home():
  return redirect(url_for('login'))


@app.route('/login')
def login():
  if 'account' in session:
    return redirect(url_for('store'))
  else:
    return render_template('login.html')


@app.route('/store')
def store():
  if 'account' in session:
    cars = fetch_cars(db)
    return render_template('store.html',
      account=session['account'],
      cars=cars)
  else:
    return redirect(url_for('login'))


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


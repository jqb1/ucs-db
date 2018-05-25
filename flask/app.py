from flask import Flask, redirect, url_for, render_template, request, session
from db_handle import DBHandle
from db import validate_user, fetch_user, fetch_cars


app = Flask(__name__)
db_handle = DBHandle(username='root', password='bazdan#20',
                     database='used_cars_store',
                     hostname='35.176.188.105', port='3306')


app.secret_key = b'\xd7\xedc\xe0Rh|R\xe5Z\x82\xc1w\x00\xfe%'


@app.route("/")
def home():
  return redirect(url_for('login'))


@app.route("/login")
def login():
  if 'username' in session:
    return redirect(url_for('view'))
  else:
    return render_template('login.html')


@app.route("/logout")
def logout():
  session.pop('username', None)
  return redirect(url_for('login'))


@app.route("/validate", methods=['POST'])
def validate():
  username = request.form['username']
  password = request.form['password']

  if validate_user(db_handle, username, password):
    session['username'] = username
    return redirect(url_for('view'))
  else:
    return redirect(url_for('login'))


@app.route("/view", methods=['GET', 'POST'])
def view():
  if 'username' in session:
    cars = fetch_cars(db_handle)
    user = fetch_user(db_handle, session['username'])
    return render_template('view.html', cars=cars, user=user)
  else:
    return redirect(url_for('login'))


@app.route("/filter", methods=['POST'])
def filter():
  # Filter form handler for view.html.
  # brand = request.form['brand']
  # ...
  # create filter variable x for fetch_cars
  # x = ...
  # cars = fetch_cars(db, x)
  # return redirect(url_for(view), cars)
  return redirect(url_for('view'))


if __name__ == '__main__':
  app.run(host="localhost", port="5000", debug=True)
  # If you want to test it locally, go with
  # app.run(host="localhost", port="80", debug=True)
  # and change database host above to server's IP
  # eg. db.connect(username='root', \
  # password='bazdan#20', host='182.321.142.999')

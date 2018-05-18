from flask import Flask, redirect, url_for, render_template, request, flash

import db
import db_test

app = Flask(__name__)
db_handle = db.connect(username='koziol', password='admin1')


@app.route("/")
def home():
  return redirect(url_for('login'))


@app.route("/login")
def login(state=None):
  return render_template('login.html')


@app.route("/validate", methods=['POST'])
def validate():
  username = request.form['username']
  password = request.form['password']

  if db.validate_user(db_handle, username, password):
    # return redirect(url_for('view'))
    # return "Hello {}!".format(username)
    return redirect(url_for('cars_list'))
  else:
    return redirect(url_for('login'))


@app.route("/cars", methods=['GET', 'POST'])
@app.route("/cars/<brand>")
def cars_list(brand=None):
  if request.method == 'POST':
    brand = request.form['brand']
    return redirect('/cars/{}'.format(brand))

  cars = db_test.get_cars(brand)
  return render_template('list_cars.html', cars_data=cars, brand=brand)


if __name__ == '__main__':
  app.run()


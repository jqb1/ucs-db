from flask import \
  Flask, \
  redirect, \
  url_for, \
  render_template, \
  request


import db


# Temporary solution. 
# We'll use flask session later.
CURRENT_USER = 'Unknown'

app = Flask(__name__)
db_handle = db.connect(username='root', \
  password='bazdan#20')


@app.route("/")
def home():
  return redirect(url_for('login'))


@app.route("/login")
def login():
  return render_template('login.html')


@app.route("/validate", methods=['POST'])
def validate():
  username = request.form['username']
  password = request.form['password']

  if db.validate_user(db_handle, username, password):
    CURRENT_USER = username
    return redirect(url_for('view'))
  else:
    return redirect(url_for('login'))


@app.route("/view", methods=['GET', 'POST'])
def view():
  cars = db.fetch_cars(db_handle)
  return render_template('view.html', \
    cars=cars, user=CURRENT_USER)


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
  app.run(host="0.0.0.0", port="80")
  # If you want to test it locally, go with
  # app.run(host="localhost", port="80", debug=True)
  # and change database host above to server's IP
  # eg. db.connect(username='root', \
  # password='bazdan#20', host='182.321.142.999')


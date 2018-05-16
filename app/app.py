from flask import Flask, redirect, url_for, render_template, request, flash,jsonify

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
        return "Hello {}!".format(username)
    else:
        return redirect(url_for('login'))


@app.route("/cars", methods=["GET"])
@app.route("/cars/<brand>")
def cars_list(brand=None):
    cars = db_test.get_cars(brand)
    return render_template('list_cars.html', cars_data=cars,brand=brand)


if __name__ == '__main__':
    app.run(host='0.0.0.0', port=80)
    # app.run(debug=True)

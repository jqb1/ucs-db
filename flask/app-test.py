from flask import Flask,jsonify,request,render_template
import MySQLdb
app=Flask(__name__)

db=MySQLdb.connect("35.176.206.50","koziol","admin1","used_cars_store")

#Configure mysql

#app.config['MYSQL_DATABASE_USER']='koziol'
#app.config['MYSQL_DATABASE_PASSWORD']='admin1'
#app.config['MYSQL_DATABASE_DB']='used_cars_store'
#app.config['MYSQL_DATABASE_HOST']='35.176.206.50'



@app.route('/hello/')
@app.route('/hello/<brand>')
def list_cars(brand=None):
    cursor=db.cursor()
    if brand:
        sql="SELECT * FROM car WHERE brand=%s"%brand
    else:
        sql="SELECT * FROM car"
    cursor.execute(sql) 
    cars_data=cursor.fetchall()
    return render_template('list_cars.html',brand=brand,cars_data=cars_data)
if __name__=="__main__":
    app.run(debug=True)

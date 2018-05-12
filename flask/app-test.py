from flask import Flask,jsonify
import pymysql
app=Flask("Hello app")

db=pymysql.connect("35.176.206.50","koziol","admin1","used_cars_store")

#Configure mysql

#app.config['MYSQL_DATABASE_USER']='koziol'
#app.config['MYSQL_DATABASE_PASSWORD']='admin1'
#app.config['MYSQL_DATABASE_DB']='used_cars_store'
#app.config['MYSQL_DATABASE_HOST']='35.176.206.50'



@app.route('/',methods=['GET'])
def index():
    cursor=db.cursor()
    sql="SELECT * FROM car"
    cursor.execute(sql) 
    data=cursor.fetchall()
    return jsonify(data) 
if "__name__"=="__main__":
    app.run(debug=True)

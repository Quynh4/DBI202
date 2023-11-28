from multiprocessing import connection
import pyodbc
import csv
# Some other example server values are
# server = 'localhost\sqlexpress' # for a named instance
# server = 'myserver,port' # to specify an alternate port
server = 'DESKTOP-1S4L5IC\SQLEXPRESS'
database = 'sourceWebSharing' # chọn db mọi người muốn truy cập
username = 'sa'
password = '123456'
# ENCRYPT defaults to yes starting in ODBC Driver 18. It's good to always specify ENCRYPT=yes on the client side to avoid MITM attacks.
connection = pyodbc.connect('DRIVER={ODBC Driver 17 for SQL Server};SERVER=' +
                            server+';DATABASE='+database+';UID='+username+';PWD=' + password)
cursor = connection.cursor()
# for row in customer_data:
#     cursor.execute('INSERT INTO student (id,last_name,first_name,user_name,password,location)'
#                    'VALUES(%s,%s,%s,%s,%s,%s)'.row)
#     #,row)

for row in cursor.execute("select * from lecturer"):
     print(row)
connection.commit()
cursor.close()
print("done")
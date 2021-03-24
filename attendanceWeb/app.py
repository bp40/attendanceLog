from flask import Flask, render_template
import mysql.connector
import os
import datetime


now = datetime.datetime.now()
app = Flask(__name__)
app.config['TEMPLATES_AUTO_RELOAD'] = True

current_time = now.strftime("%H:%M:%S")
print("Current Time =", current_time)

#mydb = mysql.connector.connect(
#    host = "localhost",
#    user = "root",
#    password = "password",
#    database = "attendance"
#)

mydb = mysql.connector.connect(
    host = 'localhost',
    user = 'root',
    password = 'password',
    database = 'attendance'
)

cursor = mydb.cursor(buffered=True)

studentQuery = ("SELECT * FROM students")

@app.route("/")
def home():
    return "Hello"

@app.route('/students/<page>')
def students(page):
    
    return page

@app.route('/attendance/<page>')
def attendance(page):
    
    attendanceCursor = mydb.cursor()
    
    try:
        if(int(page) < 1):
            return "Error"
        offset= (int(page) * 30) - 30
    except:
        return "Error"
    
    studentQuery = ("SELECT students.id, attendancelog.checkinTime, students.name FROM students INNER JOIN attendancelog ON students.id = attendancelog.studentID ORDER BY attendancelog.checkinTime DESC LIMIT 30 OFFSET %s ")
    attendanceCursor.execute(studentQuery, (offset,))
    
    allLogs = attendanceCursor.fetchall()
    mydb.commit()
    
    class Log:
        def __init__(self, ID, time, name):
            self.ID = ID
            self.time = time
            self.name = name
            
    logList = []
    for log in allLogs:
        currentLog = Log(log[0], log[1], log[2])
        logList.append(currentLog)
    
    return render_template("attendance.html", logList=logList, end=offset, page=int(page))

if __name__ == "__main__":
    app.run(host="0.0.0.0" ,debug=True)

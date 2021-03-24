import mysql.connector
import os
import sys
import RPi.GPIO as GPIO
from mfrc522 import SimpleMFRC522
from RPLCD.i2c import CharLCD
import time
import datetime

#setup

GPIO.setwarnings(False)

now = datetime.datetime.now()
current_time = now.strftime("%H:%M:%S")
run = True;

print("Current Time =", current_time)

lcd = CharLCD('PCF8574', 0x27)
reader = SimpleMFRC522()

mydb = mysql.connector.connect(
    host = "localhost",
    user = "root",
    password = "password",
    database = "attendance"
    )
    
cursor = mydb.cursor(buffered=True)

#end setup

def createTable():
    
    #create student list table
    cursor.execute("""CREATE TABLE IF NOT EXISTS`students` (
      `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
      `rfidID` varchar(255) NOT NULL DEFAULT '',
      `name` varchar(255) NOT NULL DEFAULT '',
      PRIMARY KEY (`id`)
    )""")
                  
    #create attendance table
    cursor.execute("""CREATE TABLE IF NOT EXISTS`attendancelog` (
      `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
      `studentID` int(10) unsigned NOT NULL,
      `checkinTime` datetime NOT NULL,
      PRIMARY KEY (`id`),
      KEY `attendanceLog_FK` (`studentID`),
      CONSTRAINT `attendanceLog_FK` FOREIGN KEY (`studentID`) REFERENCES `students` (`id`)
    )""")
    
def checkStudentExist(rfid, ):
    sql = ("SELECT name FROM students WHERE rfidID = '%s'")
    cursor.execute(sql, rfid)
    
    if cursor.rowcount != 0:
        return False
    else:
        return True

def addStudent(rfid, name):
    sql = ("INSERT INTO students (rfidID, name) VALUES (%s, %s)")
    values = (rfid, name)
    cursor.execute(sql, values)
    
    mydb.commit()
    print(cursor.rowcount, 'rows affected')
     
def logAttendance(rfid):
    queryID=("SELECT id FROM students WHERE rfidID LIKE %s")
    cursor.execute(queryID, (rfid,))
    result = cursor.fetchall()
    
    now = datetime.datetime.now()
    current_time = now.strftime("%H:%M:%S")
    
    #print(result[0][0]);
    
    queryLog = ("INSERT INTO attendancelog (studentID, checkinTime) VALUES (%s, %s)")
    values = (result[0][0], now)
    cursor.execute(queryLog, values)
    
    mydb.commit()
    print(cursor.rowcount, 'rows affected')
    

while (run == True):
    lcd.write_string("Please Scan:")
    now = datetime.datetime.now()
    current_time = now.strftime("%H:%M:%S")
    try:
        id, text = reader.read()
        if checkStudentExist(id):
            print("log existing")
            logAttendance(id)
        else:
            print("log new")
            addStudent(id, text)
        print('Welcome')
        print(id)
        print('Text : ')
        print(text)
        lcd.clear()
        lcd.write_string('Hello '+text + '\r\n')
        lcd.write_string('Time : ' + current_time)
        time.sleep(3)    
        
    except Exception as e:
        lcd.write_string('\n\rREAD ERROR')
        print(e)
        time.sleep(3)
    finally:
        lcd.clear()

GPIO.cleanup()
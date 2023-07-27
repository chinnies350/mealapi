from sqlalchemy import create_engine
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import sessionmaker

DQL_DATABASE = (
        r'Driver={ODBC Driver 17 for SQL Server};' 
        r'Server=192.168.1.221;'
        r'Database=Fitness_New;'
        r'UID=sqldeveloper;'
        r'PWD=SqlDeveloper$;'
        r'MARS_Connection=yes;'
        r'APP=yourapp'
)

engine = create_engine("mssql+pyodbc://sqldeveloper:SqlDeveloper$@192.168.1.221/Fitness_New?driver=ODBC+Driver+17+for+SQL+Server&Mars_Connection=Yes")
def cursorCommit():
    conn = engine.raw_connection()
    cur = conn.cursor()
    return conn,cur
# from flask import Flask, config, request
# from flask_restful import Api, Resource
# #from flask_bcrypt import Bcrypt
# from Meal_Food import Config
# from flask_cors import CORS
# import os
# import pyodbc
# import pandas as pd

# api = Api()

# connection = pyodbc.connect(
#         r'Driver={ODBC Driver 17 for SQL Server};'
#         # r'Driver={SQL Server};' 
#         r'Server=192.168.1.221;'
#         r'Database=Fitness;'
#         r'UID=sqldeveloper;'
#         r'PWD=SqlDeveloper$;'
#         r'MARS_Connection=yes;'
#         r'APP=yourapp')

# def meal(test_config=None):
#     app = Flask(__name__,
#             static_folder="E:/Saranya/MealAPI/static",
#             static_url_path="/static",
#             instance_relative_config=True,
#             template_folder='templates')

#     app.config.from_object(Config)
   
#     if test_config is None:
#         app.config.from_pyfile('config.py', silent=True)
#     else:
#         app.config.from_mapping(test_config)

#     try:
#         os.makedirs(app.instance_path)
#     except:
#         pass


#     CORS(app, resources={r"/*": {"origins": "*"}})

#     @app.after_request
#     def after_request(response):
#         response.headers.add('Access-Control-Allow-Origin', '*')
#         response.headers.add('Access-Control-Allow-Headers', 'authorization,content-type,x-api-key,Content-Type,Authorization')
#         response.headers.add('Access-Control-Allow-Methods', 'GET,PUT,POST,DELETE,OPTIONS,get,post,delete,put,options')
#         return response

#     api.init_app(app)
#     # jwt.init_app(app)
#     #bcrypt.init_app(app)
#     return app
from pydantic import BaseModel
from datetime import datetime,date,time
from typing import Dict, Optional,List
from fastapi import Query
from xmlrpc.client import boolean


class UserDietTime(BaseModel):
    userId : int
    dietTypeId : int
    dietTimeId : int
    fromTIme: time
    toTime: time
    createdBy : int

class UserFoodMenu(BaseModel):
    dietTimeId : int
    foodItemId : int
    foodItemName : str
    servingIn: int
    calories: int
    alternative : str
    createdBy: int

class MealTimeConfig(BaseModel):
    mealTypeId : int
    timeInHrs : int
    createdBy : int

class PutUserDietTime(BaseModel):
    userId : int
    dietTypeId : int
    dietTimeId : int
    fromTIme: time
    toTime: time
    updatedBy : int
    uniqueId : int


class PutUserFoodMenu(BaseModel):
    dietTimeId : int
    foodItemId : int
    foodItemName : str
    servingIn: int
    calories: int
    alternative : str
    updatedBy: int
    uniqueId : int

class PutMealTimeConfig(BaseModel):
    mealTypeId : int
    timeInHrs : int
    updatedBy : int
    uniqueId : int
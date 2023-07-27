from fastapi.routing import APIRouter
from routers.config import engine
import schemas
# from routers import Response
from typing import Optional
from fastapi import Query
import json,ast

router=APIRouter(prefix="/MealTimeConfig",tags=['MealTimeConfig'])

@router.post('')
def postMealTimeConfig(request:schemas.MealTimeConfig):
    try:
        with engine.connect() as cur:
            result=cur.execute(f"""EXEC [dbo].[postMealTimeConfig]
                                    @mealTypeId=?,
                                    @timeInHrs=?,
                                    @createdBy=?""",
                        (
                            request.mealTypeId,
                            request.timeInHrs,
                            request.createdBy                                                        
                        ))
            row=result.fetchall()
            return{"statusCode":int(row[0][1]), "response": row[0][0]}  
    except Exception as e:
        print("Exception Error",str(e))
        return{"statusCode":0,"response":"Server Error"}

@router.put('')
def putMealTimeConfig(request:schemas.PutMealTimeConfig):
    try:
        with engine.connect() as cur:
            result=cur.execute(f"""EXEC [dbo].[putMealTimeConfig]
                                    @mealTypeId=?,
                                    @timeInHrs=?,
                                    @updatedBy=?,
                                    @uniqueId=?""",
                        (
                            request.mealTypeId,
                            request.timeInHrs,
                            request.updatedBy,
                            request.uniqueId                                                        
                        ))
            row=result.fetchall()
            return{"statusCode":int(row[0][1]), "response": row[0][0]}  
    except Exception as e:
        print("Exception Error",str(e))
        return{"statusCode":0,"response":"Server Error"}
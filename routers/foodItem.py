from fastapi.routing import APIRouter
from routers.config import engine
import schemas
# from routers import Response
from typing import Optional
from fastapi import Query
import json,ast
from datetime import time,date

router=APIRouter(prefix="/foodItem",tags=['foodItem'])

def callFunction(i):
    return i.dict()

@router.get('')
def getMeal(UserId:Optional[int]=Query(None),BookingId:Optional[int]=Query(None),DietType:Optional[int]=Query(None),WakeUpTime:Optional[time]=Query(None),FromDate:Optional[date]=Query(None),ToDate:Optional[date]=Query(None),TotalCalories:Optional[int]=Query(None),CreatedBy:Optional[int]=Query(None)):
        try:
            with engine.connect() as cur:
                result = cur.execute(
                            f"""EXEC [dbo].[GetFooditem]?,?,?,?,?,?,?,?""",UserId,BookingId,DietType,WakeUpTime,FromDate,ToDate,TotalCalories,CreatedBy)
                
                rows=result.fetchone()
                result.close()
                if rows[1]==1:
                    
                    return {"statusCode": 1,"response":json.loads(rows[0]) if rows[0] != None else []}
                
                
                else:
                    return {
                        "statusCode":0,
                        "response": rows[0]
                    }
        except Exception as e:
                return {
                    "statusCode":0,
                    "response": str(e)
                }

    




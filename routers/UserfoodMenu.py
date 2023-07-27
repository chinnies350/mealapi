from fastapi.routing import APIRouter
from routers.config import engine
import schemas
# from routers import Response
from typing import Optional
from fastapi import Query
import json,ast

router=APIRouter(prefix="/UserFoodMenu",tags=['UserFoodMenu'])

@router.post('')
def postUserFoodMenu(request:schemas.UserFoodMenu):
    try:
        with engine.connect() as cur:
            result=cur.execute(f"""EXEC [dbo].[postUserFoodMenu]
                                    @dietTimeId=?,
                                    @foodItemId=?,
                                    @foodItemName=?,
                                    @servingIn=?,
                                    @calories=?,
                                    @alternative=?,
                                    @createdBy=?""",
                        (
                            request.dietTimeId,
                            request.foodItemId,
                            request.foodItemName,
                            request.servingIn,
                            request.calories,
                            request.alternative,
                            request.createdBy                                                        
                        ))
            row=result.fetchall()
            return{"statusCode":int(row[0][1]), "response": row[0][0]}  
    except Exception as e:
        print("Exception Error",str(e))
        return{"statusCode":0,"response":"Server Error"}

@router.put('')
def PutUserFoodMenu(request:schemas.PutUserFoodMenu):
    try:
        with engine.connect() as cur:
            result=cur.execute(f"""EXEC [dbo].[putUserFoodMenu]
                                    @dietTimeId=?,
                                    @foodItemId=?,
                                    @foodItemName=?,
                                    @servingIn=?,
                                    @calories=?,
                                    @alternative=?,
                                    @updatedBy=?,
                                    @uniqueId=?""",
                        (
                            request.dietTimeId,
                            request.foodItemId,
                            request.foodItemName,
                            request.servingIn,
                            request.calories,
                            request.alternative,
                            request.updatedBy,
                            request.uniqueId                                                        
                        ))
            row=result.fetchall()
            return{"statusCode":int(row[0][1]), "response": row[0][0]}  
    except Exception as e:
        print("Exception Error",str(e))
        return{"statusCode":0,"response":"Server Error"}
from fastapi.routing import APIRouter
from routers.config import engine
import schemas
# from routers import Response
from typing import Optional
from fastapi import Query
import json,ast

router=APIRouter(prefix="/UserDietTime",tags=['UserDietTime'])

@router.post('')
def postUserDietTime(request:schemas.UserDietTime):
    try:
        with engine.connect() as cur:
            result=cur.execute(f"""EXEC [dbo].[postUserDietTime]
                                    @userId=?,
                                    @dietTypeId=?,
                                    @dietTimeId=?,
                                    @fromTIme=?,
                                    @toTime=?,
                                    @createdBy=?""",
                        (
                            request.userId,
                            request.dietTypeId,
                            request.dietTimeId,
                            request.fromTIme,
                            request.toTime,
                            request.createdBy                                                        
                        ))
            row=result.fetchall()
            return{"statusCode":int(row[0][1]), "response": row[0][0]}  
    except Exception as e:
        print("Exception Error",str(e))
        return{"statusCode":0,"response":"Server Error"}

@router.put('')
def putUserDietTime(request:schemas.PutUserDietTime):
    try:
        with engine.connect() as cur:
            result=cur.execute(f"""EXEC [dbo].[putUserDietTime]
                                    @userId=?,
                                    @dietTypeId=?,
                                    @dietTimeId=?,
                                    @fromTIme=?,
                                    @toTime=?,
                                    @updatedBy=?,
                                    @uniqueId=?""",
                        (
                            request.userId,
                            request.dietTypeId,
                            request.dietTimeId,
                            request.fromTIme,
                            request.toTime,
                            request.updatedBy,
                            request.uniqueId                                                        
                        ))
            row=result.fetchall()
            return{"statusCode":int(row[0][1]), "response": row[0][0]}  
    except Exception as e:
        print("Exception Error",str(e))
        return{"statusCode":0,"response":"Server Error"}
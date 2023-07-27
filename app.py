from distutils.command.upload import upload
from fastapi.applications import FastAPI
import uvicorn
from fastapi import status,Request
from fastapi.encoders import jsonable_encoder
from fastapi.exceptions import RequestValidationError
from fastapi.responses import JSONResponse
from fastapi.middleware.cors import CORSMiddleware
from routers import foodItem,UserDietTime,UserfoodMenu,MealTimeConfig


app = FastAPI()

@app.exception_handler(RequestValidationError)
async def validation_exception_handler(request: Request, exc: RequestValidationError):
    return JSONResponse(
        status_code=status.HTTP_422_UNPROCESSABLE_ENTITY,
        content=jsonable_encoder({"detail": exc.errors(), "statusCode": "0","response":"Invalid Data"}),
    )


origins = [
    "*",
]
app.add_middleware(
    CORSMiddleware,
    allow_origins=origins,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

app.include_router(foodItem.router)
app.include_router(UserDietTime.router)
app.include_router(UserfoodMenu.router)
app.include_router(MealTimeConfig.router)

@app.get("/")
def home():
    return {
        "data":"api running successfully"
    }

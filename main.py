from fastapi import FastAPI
from chatgpt_api import ChatGPTAPI
from pydantic import BaseModel
from pydantic_settings import BaseSettings
import os


class Settings(BaseSettings):
    app_name: str = "My FastAPI App"
    debug: bool = False

settings = Settings()  # Automatically loads from environment variables

class APIRequest(BaseModel):
    input: str


app = FastAPI(settings=settings)

@app.get("/")
async def root():
    return {"message": "Hello World"}


@app.get("/hello/{name}")
async def say_hello(name: str):
    return {"message": f"Hello {name}"}

@app.post("/gptapi/v1/response")
async def gptapi_response(request: APIRequest):
    try:
        api = ChatGPTAPI(
            model_type='gpt-40'
        )
        return api.request_response(
            input_string=request.input
        )
    except Exception as e:
        return {"oh nooooo!!!!!! ---->": str(e)}

@app.post("/gptapi/v1/boogers/{thing}")
async def gptapi_booger(thing: str, body: dict):
    return {
        "response": thing,
        "body": body
    }

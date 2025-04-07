from fastapi import FastAPI, HTTPException
from chatgpt_api import ChatGPTAPI
from config import Settings
from model import APIRequest, APIResponse


settings = Settings.Settings()  # Automatically loads from environment variables
app = FastAPI(settings=settings)


@app.get("/consumer-report/v1/echo/{input}")
async def echo(input: str):
    return {f"message": {input}}


@app.post("/consumer-report/v1/product/query", response_model=APIResponse)
async def query(request: APIRequest):
    try:
        api = ChatGPTAPI(
            model_type='gpt-40'
        )
        api_response = api.create_response(
            api_request=request
        )
        # return api_response
        return APIResponse(data=api_response)
    except Exception as e:
        raise HTTPException(status_code=400, detail=f'Oh shit oh shit >>> {e}')

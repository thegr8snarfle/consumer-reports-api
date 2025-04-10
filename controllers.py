from fastapi import APIRouter, HTTPException
from model import APIRequest, APIResponse
from chatgpt_api import ChatGPTAPI

product_router = APIRouter()
util_router = APIRouter()


@util_router.get("/echo/{input}", tags=['system'])
async def echo(input: str):
    return {f"message": {input}}


@product_router.post("/query", response_model=APIResponse, tags=['product'])
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

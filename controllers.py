from fastapi import APIRouter, HTTPException
from model import APIRequest, APIResponse
from chatgpt_api import ChatGPTAPI
import logging


# Configure root logger at module import (Lambda cold start)
logging.basicConfig(level=logging.ERROR)
logger = logging.getLogger(__name__)


product_router = APIRouter()
util_router = APIRouter()


@util_router.get("/echo/{input}", tags=['system'])
async def echo(input: str):
    try:
        return {f"message": {input}}
    except Exception as e:
        message = f'>>> There was a problem reaching the API: ${e}'
        logger.error(message)
        raise HTTPException(status_code=500, detail=message)


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
        message = f'>>> There was a problem fetching product query: {e}'
        logger.error(message)
        raise HTTPException(status_code=500, detail=message)

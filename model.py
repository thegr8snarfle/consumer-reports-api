from typing import Optional, Dict, Any
from pydantic import BaseModel


class APIRequest(BaseModel):
    product_name: str
    product_sku_model_number: Optional[str] = None


class APIResponseData(BaseModel):
    response_id: str
    output: Any
    role: str
    status: str
    annotations: Any


class APIResponse(BaseModel):
    data: APIResponseData

from fastapi import FastAPI
from mangum import Mangum
from main import app


# AWS Lambda handler using Mangum adapter
handler = Mangum(app)
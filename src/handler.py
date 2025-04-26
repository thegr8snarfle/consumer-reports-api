from mangum import Mangum
from consumer_report.main import app

# AWS Lambda handler using Mangum adapter
handler = Mangum(app, lifespan="auto")
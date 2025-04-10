from fastapi import FastAPI
from config import Settings
from controllers import product_router, util_router

settings = Settings.Settings()  # Automatically loads from environment variables.tf

app = FastAPI(settings=settings)

app.include_router(util_router, prefix="/system")
app.include_router(product_router, prefix="/consumer-reports/v1/product")


@app.get("/", tags=["Root"])
async def read_root():
    return {"message": "Conssssssuuuuuummmmmmerrrrrr Reports!"}


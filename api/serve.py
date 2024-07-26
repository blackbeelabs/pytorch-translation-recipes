from fastapi import FastAPI
from pydantic import BaseModel

app = FastAPI()


class Numbers(BaseModel):
    num1: float
    num2: float


class Sum(BaseModel):
    result: float


@app.post("/sum", response_model=Sum)
async def calculate_sum(numbers: Numbers):
    return Sum(result=numbers.num1 + numbers.num2)


if __name__ == "__main__":
    import uvicorn

    uvicorn.run(app, host="0.0.0.0", port=8000)

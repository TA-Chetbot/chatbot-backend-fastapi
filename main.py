from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel
from typing import Union
from ai_model import preprocess_text, generate_text_sampling_top_p_nucleus_22

app = FastAPI()

origins = ["*"]

app.add_middleware(
    CORSMiddleware,
    allow_origins=origins,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

class AIResponseModel(BaseModel):
    question: str

@app.get("/")
def read_root():
    response = {"message": "hello world", "status": "ok"}
    return response

@app.post("/get_answer")
def get_answer(ai_response: AIResponseModel):
    question = preprocess_text(ai_response.question)
    answer = generate_text_sampling_top_p_nucleus_22(question)
    return {"question": question, "answer": answer}
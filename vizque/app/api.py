from fastapi import FastAPI
from typing import List
from fastapi.middleware.cors import CORSMiddleware
import sys
import json
sys.path.append("/VizQue/vizque/app/nimlibs")
import nowtime
import objectCast


app = FastAPI()

origins = [
    "http://0.0.0.0:5555",
    "0.0.0.0:5555"
]

query = [{"data": "test"}]

app.add_middleware(
    CORSMiddleware,
    allow_origins=origins,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)


@app.get("/", tags=["root"])
async def read_root() -> dict:
    t = nowtime.nowtime()
    dates = json.dumps(t, default=objectCast.default_method).replace('"','')
    return {"time": dates}

@app.get("/testquery", tags=["query"])
async def get_tst_query() -> dict:
    return {"data": query}

@app.post("/testquery", tags=["query"])
async def get_test_query(q: dict) -> dict:
    query.append(q)
    # print(query)
    return {
        "data": q,
        "message": "Get Query!!"
    }
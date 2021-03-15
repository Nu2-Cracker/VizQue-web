from fastapi import FastAPI, Depends
from typing import List
from fastapi.middleware.cors import CORSMiddleware
import sys
import json
sys.path.append("/prj/server/app/nimlibs")
import nowtime
import vizque
import os
import objectCast


app = FastAPI()

origins = [
    "http://0.0.0.0:5555",
    "0.0.0.0:5555"
]

query = [{
     "edges": [],
     "nodes": []
}]

app.add_middleware(
    CORSMiddleware,
    allow_origins=origins,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"]
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
    print(q["data"])
    return {
        "data": q,
        "message": "Get Query!!"
    }

@app.get("/vizque", tags=["query"])
async def calc_network_get() -> dict:
    return {"data": query}
    

@app.post("/vizque", tags=["query"])
async def calc_network_post(q: dict) -> dict:
    keyword = q["data"]
    level = q["level"]
    jsonData = vizque.run_vizque(keyword, level)
    jsonData = json.loads(jsonData)
    query[0] = jsonData
    return {
        "data": q,
        "message": "Get Query!!"
    }

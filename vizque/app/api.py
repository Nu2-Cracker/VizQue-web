from fastapi import FastAPI
from typing import List
from fastapi.middleware.cors import CORSMiddleware
import datetime
import sys
import json
sys.path.append("/VizQue/vizque/app/nimlibs")
import nowtime
import objectCast


app = FastAPI()

origins = [
    "http://localhost:5555",
    "localhost:5555"
]

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
    dates = json.dumps(t, default=objectCast.default_method)
    return {"time": dates}

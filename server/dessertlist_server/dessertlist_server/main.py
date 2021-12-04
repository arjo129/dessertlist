from typing import List

from fastapi import FastAPI, HTTPException
from pydantic import BaseModel

import hashlib
import os
import pickle
import uvicorn

class ActivityDetails(BaseModel):
    name: str
    location: str
    tags: List[str]

global place_details
place_details = []

app = FastAPI()
backup_file_name = "activities.bkp"

global secret
secret = ""

def check_secret(secret_id):
    global secret
    # compare hashes to prevent against timing attack
    hasher = hashlib.sha256(bytes(secret_id, "utf-8"))
    if secret != hasher.hexdigest():
        raise HTTPException(status_code=403, detail="unauthorized access code")

@app.post("/places")
def add_place(place: ActivityDetails, access_code: str):
    check_secret(access_code)
    global place_details
    place_details.append(place)
    with open(backup_file_name, "wb") as f:
        pickle.dump(place_details, f)
    return {"status": "OK"}

@app.delete("/places/{place_id}")
def delete_place(place_id: int, access_code: str):
    check_secret(access_code)
    global place_details
    if len(place_details) > place_id:
        raise HTTPException(status_code=404, detail="place not found")
    del place_details[int(place_id)]
    with open(backup_file_name, "wb") as f:
        pickle.dump(place_details, f)
    return {"status": "OK"}

@app.get("/")
def read_root(access_code: str):
    check_secret(access_code)
    global place_details
    return place_details

def start():
    with open("secret.scrt") as f:
        global secret
        hasher = hashlib.sha256(bytes(f.read(), "utf-8"))
        secret = hasher.hexdigest()

    if (os.path.isfile(backup_file_name)):
        with open(backup_file_name, "rb") as f:
            global place_details
            place_details = pickle.load(f)
    uvicorn.run("dessertlist_server.main:app", host="0.0.0.0", log_level="debug")

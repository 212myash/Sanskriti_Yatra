import os

from fastapi import FastAPI, HTTPException
from pymongo import MongoClient

app = FastAPI()

mongo_uri = os.getenv("MONGO_URI")
client = MongoClient(mongo_uri) if mongo_uri else None
db = client["app"] if client else None
collection = db["test"] if db else None

# API Endpoint to Get Users
@app.get("/users")
def get_users():
    if collection is None:
        raise HTTPException(status_code=503, detail="Database is not configured")

    try:
        users = list(collection.find({}, {"_id": 0}))  # Get all users
        return {"users": users}
    except Exception as exc:
        raise HTTPException(status_code=500, detail="Failed to fetch users") from exc

# API Endpoint to Add User
# @app.post("/add_user")
# def add_user(name: str, email: str):
#     user = {"name": name, "email": email}
#     collection.insert_one(user)
#     return {"message": "User added successfully!"}

if __name__ == "__main__":
    import uvicorn # type: ignore
    uvicorn.run(app, host="0.0.0.0", port=8000)
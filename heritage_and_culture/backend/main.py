from fastapi import FastAPI
from pymongo import MongoClient

app = FastAPI()

# MongoDB Connection
client = MongoClient("mongodb+srv://212myashraj:FNaWFWjBCJhWUijZ@cluster0.rwwxb.mongodb.net/")
db = client["app"]  # Database name
collection = db["test"]  # Collection (table) name

# API Endpoint to Get Users
@app.get("/users")
def get_users():
    users = list(collection.find({}, {"_id": 0}))  # Get all users
    return {"users": users}

# API Endpoint to Add User
# @app.post("/add_user")
# def add_user(name: str, email: str):
#     user = {"name": name, "email": email}
#     collection.insert_one(user)
#     return {"message": "User added successfully!"}

if __name__ == "__main__":
    import uvicorn # type: ignore
    uvicorn.run(app, host="0.0.0.0", port=8000)
import firebase_admin
from firebase_admin import credentials, firestore

# Initialize Firebase
cred = credentials.Certificate("serviceAccountKey.json")
firebase_admin.initialize_app(cred)

# Access Firestore
db = firestore.client()

# Function to add data
def add_user_to_firestore():
    collection_name = "users"
    user_data = {
        "name": "Daniel",
        "email": "daniel@gmail.com",
        "age": 20
    }

    # Add data to Firestore
    db.collection(collection_name).add(user_data)
    print("User added to Firestore!")

# Call the function to add data
if __name__ == "__main__":
    add_user_to_firestore()

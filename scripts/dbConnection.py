import json
import mysql.connector

conn = mysql.connector.connect(
    host="ben6d65e6hta2p7weqel-mysql.services.clever-cloud.com",      
    user="uzmdloyu14uy72q5", 
    password="n7gk3Ow7uwkExgyZSwxQ",  
    database="ben6d65e6hta2p7weqel"    
)


cursor = conn.cursor()

# Execute a query
cursor.execute("SELECT * FROM game")

results = cursor.fetchall()
for row in results:
    print(row)



# Open and read the JSON file
with open('scripts/game_data.json', 'r') as file:
    data = json.load(file)


for i in data:
    cursor.execute(
        f'INSERT INTO game VALUES (default, "{i['name']}", {float(i['price'].replace("R", ""))}, "{i['image']}")'
    )
    print(i['name'] + "add to db")
        



conn.commit()
cursor.close()
conn.close()

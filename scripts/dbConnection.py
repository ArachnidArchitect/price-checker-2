import mysql.connector

# Establish a connection to the database
conn = mysql.connector.connect(
    host="ben6d65e6hta2p7weqel-mysql.services.clever-cloud.com",      # Database host
    user="uzmdloyu14uy72q5", 
    password="uzmdloyu14uy72q5",  
    database="ben6d65e6hta2p7weqel"    
)


cursor = conn.cursor()

# Execute a query
cursor.execute("SELECT * FROM")

# Fetch results
results = cursor.fetchall()
for row in results:
    print(row)

# Close the cursor and connection
cursor.close()
conn.close()

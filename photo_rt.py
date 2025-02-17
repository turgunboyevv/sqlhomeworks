import pyodbc

conn = pyodbc.connect(
    "DRIVER={SQL Server};"
    "SERVER=WIN-A5I5TM5OKQQ\SQLEXPRESS;"
    "DATABASE=class2;"
    "Trusted_Connection=yes;"
)
cursor = conn.cursor()

cursor.execute("SELECT image_data FROM photos WHERE id = 1")
row = cursor.fetchone()

if row:
    with open("output.jpg", "wb") as file:
        file.write(row[0])  

    print("Rasm 'output.jpg' sifatida saqlandi!")
else:
    print("Rasm topilmadi!")

cursor.close()
conn.close()

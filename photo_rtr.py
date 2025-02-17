import pyodbc  # SQL-Server bilan ishlash uchun kutubxona

# SQL Server bazasiga ulanish
conn = pyodbc.connect(
    "DRIVER={SQL Server};"
    "SERVER=WIN-A5I5TM5OKQQ\SQLEXPRESS;"
    "DATABASE=class2;"
    "Trusted_Connection=yes;"
)
cursor = conn.cursor()

# Rasmni SQL Serverdan olish
cursor.execute("SELECT image_data FROM photos WHERE id = 1")  # ID 1 bo'lgan rasmni olish
row = cursor.fetchone()

if row:
    with open("output.jpg", "wb") as file:  #  Faylga yozish
        file.write(row[0])  

    print("Rasm 'output.jpg' sifatida saqlandi!")
else:
    print("Rasm topilmadi!")

# Ulashni yopish
cursor.close()
conn.close()

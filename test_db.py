from config.db_connection import get_db_connection

conn = get_db_connection()

if conn:
    cursor = conn.cursor()
    # Example query
    cursor.execute("SELECT DiseaseName FROM Disease")
    for row in cursor.fetchall():
        print(row)
    conn.close()

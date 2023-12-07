import psycopg2
def get_sql(file):
    with open(file,"r",encoding="utf-8") as f:
        output = f.read()
    return output

def get_result(script,conn,query=False):
    cursor = conn.cursor()
    if not query:
        cursor.execute(script)
        result = cursor.fetchall()
        print(result)
    else:
        for sql in script.split(";"):
            cursor.execute(sql)
            result = cursor.fetchall()
            print(result)
    conn.commit()
    conn.close()


if __name__ == "__main__":

    dbname = 'your_database'
    user = 'your_user'
    password = 'your_password'
    host = 'your_host'
    port = 'your_port'
    conn = psycopg2.connect(dbname=dbname, user=user, password=password, host=host, port=port)

    create = "../createDB.sql"
    insert = "../insertData.sql"
    query = "../query.sql"
    files = [create,insert,query]

    for i,file in enumerate(files):
        script = get_sql(file)
        get_result(script,
                conn,
                True if i==len(files) else False)
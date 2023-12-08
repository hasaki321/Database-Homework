import psycopg2
def get_sql(file):
    with open(file,"r",encoding="utf-8") as f:
        output = f.read()
    return output

def get_result(script,conn,query=False):
    cursor = conn.cursor()
    if not query:
        cursor.execute(script)
        try:
            result = cursor.fetchall()
        except:
            result = "no output"
        finally:
            print(result)
    else:
        for i,sql in enumerate(script.split(";")[:-1]):
            try:
                cursor.execute(sql)
            except psycopg2.ProgrammingError as e:
                print(f"error at sql:{i+1}, {e}")
            try:
                result = cursor.fetchall()
            except psycopg2.ProgrammingError as e:
                print(f"not query type and return nothing:{i+1}, {e}")
                result = []
            finally:
                print(f"successfully excute sql {i+1}") if result and len(result) > 0 else print("false")
    conn.commit()
    


if __name__ == "__main__":

    dbname = 'postgres'
    user = 'postgres'
    password = 'hrs2004924'
    host = 'localhost'
    port = '5432'
    conn = psycopg2.connect(dbname=dbname, user=user, password=password, host=host, port=port)

    create = "../createDB.sql"
    insert = "../insertData.sql"
    query = "../query.sql"
    files = [create,insert,query]

    for i,file in enumerate(files):
        script = get_sql(file)
        get_result(script,
                conn,
                True if i==len(files)-1 else False)
    conn.close()
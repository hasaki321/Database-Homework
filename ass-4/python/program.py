import psycopg2
import os
import json
import argparse
def get_all_files():
    global conn
    create = "./createDB.sql"
    insert = "./insertData.sql"
    query = "./queries.sql"
    files = [create,insert,query]

    for i,file in enumerate(files):
        script = get_sql(file)
        get_result(script,
                conn,
                True if i==len(files)-1 else False)

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
    
def get_args():
    parser = argparse.ArgumentParser()
    parser.add_argument("-a",action=get_all_files)
    parser.add_argument("-f",type=str)
    parser.add_argument("-r",action=rm_conf)
    parser.add_argument("s", action=exec_sql,)
    args = parser.parse_args()
    return args

def exec_sql():
    global conn
    sql = ""
    while not sql=="q":
        sql = input("please input sql (press q to quit):")
        get_result(sql,conn)
    print("Quit Program")

def rm_conf():
    if os.path.exists("db_config.json"):
        os.remove("db_config.json")

def get_conf():
    db_config = None
    if not os.path.exists("db_config.json"):
        
        db_config = {
            "host" : input('please input host of database:'),
            "port" : input('please input port of database:'),
            "dbname" : input('please input name of database:'),
            "user" : input('please input user of database:'),
            "password" : input('please input password of user:')
        }
        json_config = json.dumps(db_config)
        with open("db_config.json","w") as f:
            f.write(json_config)
    
    else:
        with open("db_config.json","r") as f:
            db_config = json.load(f)
    return db_config

def get_conn():
    db_config = get_conf()
    conn = psycopg2.connect(dbname=db_config['dbname'], user=db_config["user"], password=db_config["password"], host=db_config["host"], port=db_config["port"])
    return conn

if __name__ == "__main__":
    conn = get_conn()
    args = get_args()

    if args.f:
        get_sql(args.f)
    
    conn.close()

    
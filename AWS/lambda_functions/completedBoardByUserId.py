import json
import psycopg2
import os

def lambda_handler(event, context):
    conn = None
    cursor = None
    try:
        if 'queryStringParameters' in event and 'userID' in event['queryStringParameters']:
            user_id = event['queryStringParameters']['userID']
        else:
            raise ValueError("Missing 'userID' in the query parameters")

        conn = psycopg2.connect(
            host=os.environ['DB_HOST'],
            port=os.environ['DB_PORT'],
            user=os.environ['DB_USER'],
            password=os.environ['DB_PASS'],
            database=os.environ['DB_NAME']
        )
        cursor = conn.cursor()

        query = """
            SELECT id, boardpossibility_id, userid
            FROM completedboards
            WHERE userid = %s;
        """
        cursor.execute(query, (user_id,))
        results = cursor.fetchall()

        completed_boards = []
        for row in results:
            completed_boards.append({
                'id': row[0],
                'boardpossibility_id': row[1],
                'userid': row[2]
            })

        return {
            'statusCode': 200,
            'body': json.dumps(completed_boards),
            'headers': {'Content-Type': 'application/json'}
        }

    except Exception as e:
        return {
            'statusCode': 500,
            'body': json.dumps({'error': str(e)}),
            'headers': {'Content-Type': 'application/json'}
        }

    finally:
        if cursor:
            cursor.close()
        if conn:
            conn.close()

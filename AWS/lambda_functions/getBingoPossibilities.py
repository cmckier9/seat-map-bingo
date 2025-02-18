import os
import psycopg2
import json
from datetime import datetime

def lambda_handler(event, context):
    try:
        print("Event: ", event)

        conn = psycopg2.connect(
            host=os.environ['DB_HOST'],
            port=os.environ.get('DB_PORT', 5432),
            user=os.environ['DB_USER'],
            password=os.environ['DB_PASS'],
            database=os.environ['DB_NAME'],
        )
        cursor = conn.cursor()

        query = "SELECT * FROM seat_possibilities"
        cursor.execute(query)

        possible_bingos = cursor.fetchall()

        cursor.close()
        conn.close()

        return {
            'statusCode': 200,
            'body': json.dumps(possible_bingos),
            'headers': {'Content-Type': 'application/json'}
        }

    except Exception as e:
        print(f"Error occurred: {str(e)}")
        return {
            'statusCode': 500,
            'body': json.dumps({'error': str(e)}),
            'headers': {'Content-Type': 'application/json'}
        }

import os
import psycopg2
import json
from datetime import datetime

def lambda_handler(event, context):
    try:
        print("Event: ", event)

        user_id = event.get('queryStringParameters', {}).get('userID')
        
        if not user_id:
            return {
                'statusCode': 400,
                'body': json.dumps({'error': 'Missing userID parameter'}),
                'headers': {'Content-Type': 'application/json'}
            }

        conn = psycopg2.connect(
            host=os.environ['DB_HOST'],
            port=os.environ.get('DB_PORT', 5432),
            user=os.environ['DB_USER'],
            password=os.environ['DB_PASS'],
            database=os.environ['DB_NAME'],
        )
        cursor = conn.cursor()

        query = "SELECT FlightID, SeatNumber, DateSat, BingoActive, CompletedBoard FROM SeatHistory WHERE UserID = %s"
        cursor.execute(query, (user_id,))

        seat_history = cursor.fetchall()

        seat_history_list = [
            {"FlightID": row[0], "SeatNumber": row[1], "DateSat": row[2].isoformat() if isinstance(row[2], datetime) else row[2], "BingoActive": row[3], "CompleteBoardId": row[4]}
            for row in seat_history
        ]

        cursor.close()
        conn.close()

        return {
            'statusCode': 200,
            'body': json.dumps(seat_history_list),
            'headers': {'Content-Type': 'application/json'}
        }

    except Exception as e:
        print(f"Error occurred: {str(e)}")
        return {
            'statusCode': 500,
            'body': json.dumps({'error': str(e)}),
            'headers': {'Content-Type': 'application/json'}
        }

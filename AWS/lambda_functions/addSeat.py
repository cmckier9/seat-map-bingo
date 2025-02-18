import json
import psycopg2
import os

def lambda_handler(event, context):
    conn = None
    cursor = None
    try:
        if 'body' in event and event['body']:
            body = json.loads(event['body'])
        else:
            raise ValueError("Missing 'body' in the event")

        if 'userID' not in body or 'seat' not in body or 'flightID' not in body:
            raise ValueError("Missing 'userID', 'seat', or 'flightID' in the request body")

        user_id = body['userID']
        seat_number = body['seat']
        flight_id = body['flightID']

        conn = psycopg2.connect(
            host=os.environ['DB_HOST'],
            port=os.environ['DB_PORT'],
            user=os.environ['DB_USER'],
            password=os.environ['DB_PASS'],
            database=os.environ['DB_NAME']
        )
        cursor = conn.cursor()

        query = """
            INSERT INTO seathistory (userid, flightid, seatnumber, datesat, bingoactive)
            VALUES (%s, %s, %s, CURRENT_TIMESTAMP, TRUE)
            RETURNING historyid;
        """
        cursor.execute(query, (user_id, flight_id, seat_number))
        new_history_id = cursor.fetchone()[0]
        conn.commit()

        return {
            'statusCode': 200,
            'body': json.dumps({
                'message': 'Seat added successfully',
                'historyid': new_history_id
            }),
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

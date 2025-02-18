import os
import requests
import json

def lambda_handler(event, context):
    try:
        token = get_amadeus_access_token()

        seat_map_url = "https://test.airlines.api.amadeus.com/v2/shopping/seatmaps?marketingAirlineCode=WN&marketingFlightNumber=7102&originLocationCode=DAL&destinationLocationCode=HOU&departureDate=2024-11-24&showMilesPrice=false"

        response = requests.get(
            seat_map_url,
            headers={
                "Authorization": f"Bearer {token}",
                "Content-Type": "application/json"
            }
        )

        if response.status_code == 200:
            
            return {
                'statusCode': 200,
                'body': json.dumps(response.json()),
                'headers': {'Content-Type': 'application/json'}
            }
        else:
            return {
                'statusCode': response.status_code,
                'body': json.dumps({'error': response.text}),
                'headers': {'Content-Type': 'application/json'}
            }

    except Exception as e:
        return {
            'statusCode': 500,
            'body': json.dumps({'error': str(e)}),
            'headers': {'Content-Type': 'application/json'}
        }

def get_amadeus_access_token():
    url = "https://test.airlines.api.amadeus.com/v1/security/oauth2/token"
    payload = {
        "grant_type": "client_credentials",
        "client_id": os.environ['AMADEUS_API_KEY'],
        "client_secret": os.environ['AMADEUS_API_SECRET']
    }
    
    response = requests.post(url, data=payload)
    print(response)
    if response.status_code == 200:
        return response.json().get("access_token")
    else:
        raise Exception(f"Failed to get access token: {response.text}")

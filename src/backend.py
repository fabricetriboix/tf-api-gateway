import json

def entry_point(event, context):
    print(f"Received event: {event}")
    response = {
        'statusCode': 200,
        'body': "Backend Lambda version 1"
    }
    tmp = json.dumps(response)
    print(f"Returning: {tmp}")
    return tmp

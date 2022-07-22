import json

def entry_point(event, context):
    print(f"Received event: {event}")
    data = {
        'message': "Backend Lambda version 1"
    }
    tmp = json.dumps(data)
    print(f"Returning: {tmp}")
    return tmp

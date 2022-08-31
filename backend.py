def entry_point(event, context):
    print(f"Received event: {event}")
    response = {
        'statusCode': 200,
        'body': "Backend Lambda version 1"
    }
    print(f"Returning: {response}")
    return response

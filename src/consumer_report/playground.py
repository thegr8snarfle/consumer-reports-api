import os
from openai import OpenAI
from chatgpt_api import ChatGPTAPI

api_key = os.environ['api_key']
# client = OpenAI(api_key=api_key)

# response = client.responses.create(
#     model="gpt-4o",
#     input="Write a one-sentence bedtime story about a unicorn."
# )

api = ChatGPTAPI(
    model_type='gpt-40',
    auth_token=api_key
)

response = api.request_response(
    'Describe a scene with a beautiful girl riding an american akita'
)

print(response.output_text)


import os
import json
from openai import OpenAI
from model import APIRequest

class ChatGPTAPI:
    def __init__(self, model_type):
        api_key = os.environ['api_key']
        self.model_type = model_type
        self.auth_token = api_key
        self.client = self.build_openai_client(self.auth_token)

    @property
    def model_type(self):
        return self._model_type

    @model_type.setter
    def model_type(self, value):
        self._model_type = value

    @property
    def auth_token(self):
        return self._auth_token

    @auth_token.setter
    def auth_token(self, value):
        self._auth_token = value

    @property
    def client(self):
        return self._client

    @client.setter
    def client(self, value: OpenAI):
        self._client = value

    def build_openai_client(self, api_key):
        try:
            client = OpenAI(api_key=api_key)
            return client
        except Exception as e:
            print(f'couldnt build openai client: {e}')

    def create_response(self, api_request: APIRequest):
        try:
            prompt_input = f"""As a prospective buyer, in JSON format, i would like to know the following about 
                {api_request.product_name}: the name, description, purpose served, price, where to buy, manufacturer SKU, pros and cons from
                user reviews. 
            """
            if self.client is None:
                raise Exception('No client initialized.')
            api_response = self.client.responses.create(
                model='gpt-3.5-turbo',
                input=prompt_input,
                tool_choice='none'
            )
            # TODO find better/cleaner syntax
            return {
                'response_id': api_response.id,
                'output': self.parse_json(api_response.output[0].content[0].text),
                'status': api_response.output[0].status,
                'role': api_response.output[0].role,
                'annotations': api_response.output[0].content[0].annotations,
                # 'usage': api_response.usage
            }
        except Exception as e:
            raise Exception(e)

    def parse_json(self, raw_json: str):
        json_str = None
        if raw_json.startswith("json"):
            # Remove the prefix and any leading whitespace/newlines
            json_str = raw_json[len("json"):].strip()
        else:
            json_str = raw_json

        if json_str is not None:
            return json.loads(json_str)
        else:
            raise Exception('Unable to parse JSON response.')
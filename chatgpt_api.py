import os
from openai import OpenAI


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

    def request_response(self, input_string):
        try:
            if self.client is None:
                raise Exception('No client initialized.')
            return self.client.responses.create(
                model="gpt-4o",
                input=input_string
            )
        except Exception as e:
            return {
                'error': str(e)
            }

from langchain.llms import OpenAI

from langchain.chat_models import ChatOpenAI
from langchain.schema import (
    AIMessage,
    HumanMessage,
    SystemMessage
)


llm = OpenAI(openai_api_key="...")
llm = OpenAI(temperature=0.9)
llm.predict("What would be a good company name for a company that makes colorful socks?")



chat = ChatOpenAI(temperature=0)
chat.predict_messages([HumanMessage(content="Translate this sentence from English to French. I love programming.")])
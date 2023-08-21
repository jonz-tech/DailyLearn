from langchain.llms import OpenAI

from langchain.chat_models import ChatOpenAI
from langchain.schema import (
    AIMessage,
    HumanMessage,
    SystemMessage
)

# 终端中设置
# export OPENAI_API_KEY="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"


# llm = OpenAI(openai_api_key="")
llm = OpenAI(openai_api_key="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",temperature=0.9)
llm.predict("What would be a good company name for a company that makes colorful socks?")


chat = ChatOpenAI(openai_api_key="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",temperature=0)
chat.predict_messages([HumanMessage(content="Translate this sentence from English to French. I love programming.")])
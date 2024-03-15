from langchain.llms import OpenAI
from langchain.chat_models import ChatOpenAI
import lc01_llmenviroment.py
llm = OpenAI()
chat_model = ChatOpenAI()

llm.predict("hi!")
#>>> "Hi"

chat_model.predict("hi!")
#>>> "Hi"

text = "What would be a good company name for a company that makes colorful socks?"

llm.predict(text)
# >> Feetful of Fun

chat_model.predict(text)
# >> Socks O'Color



from langchain.schema import HumanMessage

text = "What would be a good company name for a company that makes colorful socks?"
messages = [HumanMessage(content=text)]

llm.predict_messages(messages)
# >> Feetful of Fun

chat_model.predict_messages(messages)
# >> Socks O'Color
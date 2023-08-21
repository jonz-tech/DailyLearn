from langchain import PromptTemplate

prompt_template = PromptTemplate.from_template(
    "Tell me a {adjective} joke about {content}."
)
# format入参
prompt_template.format(adjective="funny", content="chickens")


from langchain import PromptTemplate
# 无参数
prompt_template = PromptTemplate.from_template(
"Tell me a joke"
)
prompt_template.format()


from langchain import PromptTemplate

# 批量入参： 由于缺少content 入参，所以这里会报错
invalid_prompt = PromptTemplate(
    input_variables=["adjective"],
    template="Tell me a {adjective} joke about {content}."
)
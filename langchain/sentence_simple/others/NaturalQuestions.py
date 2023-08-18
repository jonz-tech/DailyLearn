from sentence_transformers import SentenceTransformer, util
model = SentenceTransformer('nq-distilbert-base-v1')

query_embedding = model.encode('How many people live in London?')

#The passages are encoded as [ [title1, text1], [title2, text2], ...]
passage_embedding = model.encode([['London', 'London has 9,787,426 inhabitants at the 2011 census.']])

print("Similarity:", util.cos_sim(query_embedding, passage_embedding))
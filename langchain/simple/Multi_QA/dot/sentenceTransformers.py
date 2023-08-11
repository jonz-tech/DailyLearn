#多语言问答模型

# multi-qa-MiniLM-L6-dot-v1、multi-qa-distilbert-dot-v1、multi-qa-mpnet-base-dot-v1

from transformers import pipeline

# 加载 multi-qa-MiniLM-L6-dot-v1 模型
from sentence_transformers import SentenceTransformer, util

query = "where is the Great Wall of China？"
docs = ["Around 9 Million people live in London", "London is known for its financial district",'the Great Wall of China is in beijing']

#Load the model
model = SentenceTransformer('sentence-transformers/multi-qa-MiniLM-L6-dot-v1')

#Encode query and documents
query_emb = model.encode(query)
doc_emb = model.encode(docs)

#Compute dot score between query and all document embeddings
scores = util.dot_score(query_emb, doc_emb)[0].cpu().tolist()

#Combine docs & scores
doc_score_pairs = list(zip(docs, scores))

#Sort by decreasing score
doc_score_pairs = sorted(doc_score_pairs, key=lambda x: x[1], reverse=True)

#Output passages & scores
for doc, score in doc_score_pairs:
    print(score, doc)



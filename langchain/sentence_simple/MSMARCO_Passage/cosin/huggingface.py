from transformers import AutoTokenizer, AutoModel
import torch
import torch.nn.functional as F

#Mean Pooling - Take average of all tokens
def mean_pooling(model_output, attention_mask):
    token_embeddings = model_output.last_hidden_state #First element of model_output contains all token embeddings
    input_mask_expanded = attention_mask.unsqueeze(-1).expand(token_embeddings.size()).float()
    return torch.sum(token_embeddings * input_mask_expanded, 1) / torch.clamp(input_mask_expanded.sum(1), min=1e-9)


#Encode text
def encode(texts):
    # Tokenize sentences
    encoded_input = tokenizer(texts, padding=True, truncation=True, return_tensors='pt')

    # Compute token embeddings
    with torch.no_grad():
        model_output = model(**encoded_input, return_dict=True)

    # Perform pooling
    embeddings = mean_pooling(model_output, encoded_input['attention_mask'])

    # Normalize embeddings
    embeddings = F.normalize(embeddings, p=2, dim=1)
    
    return embeddings


# Sentences we want sentence embeddings for
query = "where is the Great Wall of China？"
docs = ["the great wall is about 13,171km in china", "London is known for its financial district",'the Great Wall is in beijing']

# Load model from HuggingFace Hub
tokenizer = AutoTokenizer.from_pretrained("sentence-transformers/msmarco-MiniLM-L6-cos-v5")
model = AutoModel.from_pretrained("sentence-transformers/msmarco-MiniLM-L6-cos-v5")

#Encode query and docs
query_emb = encode(query)
doc_emb = encode(docs)

#Compute dot score between query and all document embeddings
# 点积得分算法，非点积相似度算法
scores = torch.mm(query_emb, doc_emb.transpose(0, 1))[0].cpu().tolist()

#Combine docs & scores
doc_score_pairs = list(zip(docs, scores))

#Sort by decreasing score
doc_score_pairs = sorted(doc_score_pairs, key=lambda x: x[1], reverse=True)

#Output passages & scores
for doc, score in doc_score_pairs:
    print(score, doc)

# ================================================================
# 计算点积得分
dot_product = torch.mm(query_emb, doc_emb.transpose(0, 1))[0]

# 计算向量范数
norm_query = torch.norm(query_emb)
norm_doc = torch.norm(doc_emb[0])  # 假设计算第一个文档的相似度

# 计算余弦相似度
cosine_similarity = dot_product / (norm_query * norm_doc)

print(cosine_similarity)
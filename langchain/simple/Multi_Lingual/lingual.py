from transformers import AutoTokenizer, AutoModel
import torch
from sentence_transformers import SentenceTransformer, util
# 加载预训练模型和分词器
model_name = "sentence-transformers/paraphrase-multilingual-MiniLM-L12-v2"
tokenizer = AutoTokenizer.from_pretrained(model_name)
model = AutoModel.from_pretrained(model_name)

# 输入文本
text = "Hello, how are you?"
cmpText = "3月7日 我爱北京"

# 对文本进行分词和编码
inputs = tokenizer(text, return_tensors="pt", padding=True, truncation=True)
doc_emb = tokenizer(cmpText, return_tensors="pt", padding=True, truncation=True)

# 使用模型生成嵌入向量
with torch.no_grad():
    outputs = model(**inputs)
    query_emb = outputs.last_hidden_state.mean(dim=1)  # 使用平均池化获取文本嵌入向量
    outputscmp = model(**doc_emb)
    query_embcmp = outputscmp.last_hidden_state.mean(dim=1)  # 使用平均池化获取文本嵌入向量

# print(embeddings)


scores = util.cos_sim(query_emb, query_embcmp)[0].cpu().tolist()

#Combine docs & scores
doc_score_pairs = list(zip(text, scores))

#Sort by decreasing score
doc_score_pairs = sorted(doc_score_pairs, key=lambda x: x[1], reverse=True)

#Output passages & scores
for doc, score in doc_score_pairs:
    print(score, text)

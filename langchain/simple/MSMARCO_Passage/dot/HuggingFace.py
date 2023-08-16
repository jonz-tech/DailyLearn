from transformers import AutoTokenizer, AutoModel
import torch

#CLS Pooling - Take output from first token
def cls_pooling(model_output):
    return model_output.last_hidden_state[:,0]

#Encode text
def encode(texts):
    # Tokenize sentences
    encoded_input = tokenizer(texts, padding=True, truncation=True, return_tensors='pt')

    # Compute token embeddings
    with torch.no_grad():
        model_output = model(**encoded_input, return_dict=True)

    # Perform pooling
    embeddings = cls_pooling(model_output)

    return embeddings


# Sentences we want sentence embeddings for
query = "where is the Great Wall of China？"
docs = ["the great wall is about 13,171km in china", "London is known for its financial district",'the Great Wall is in beijing']

# Load model from HuggingFace Hub
tokenizer = AutoTokenizer.from_pretrained("sentence-transformers/msmarco-distilbert-base-tas-b")
model = AutoModel.from_pretrained("sentence-transformers/msmarco-distilbert-base-tas-b")

#Encode query and docs
query_emb = encode(query)
doc_emb = encode(docs)

#Compute dot score between query and all document embeddings
scores = torch.mm(query_emb, doc_emb.transpose(0, 1))[0].cpu().tolist()

#Combine docs & scores
doc_score_pairs = list(zip(docs, scores))

#Sort by decreasing score
doc_score_pairs = sorted(doc_score_pairs, key=lambda x: x[1], reverse=True)

#Output passages & scores
for doc, score in doc_score_pairs:
    print(score, doc)

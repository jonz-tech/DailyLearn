# from sentence_transformers import SentenceTransformer, util
# from PIL import Image

# #Load CLIP model
# model = SentenceTransformer('clip-ViT-L-14')

# #Encode an image:
# img_emb = model.encode(Image.open('dd.jpg'))

# #Encode text descriptions
# text_emb = model.encode(['Two dogs in the snow', 'A cat on a table', 'A picture of London at night'])

# #Compute cosine similarities 
# cos_scores = util.cos_sim(img_emb, text_emb)
# print(cos_scores)



import torch
import numpy as np
from PIL import Image
from sklearn.decomposition import PCA
from sentence_transformers import SentenceTransformer, util
from PIL import Image
import os
#Load CLIP model
model = SentenceTransformer('clip-ViT-B-32')

absolute_image_path = os.path.join(os.getcwd(), "simple/Image_Text/two_dogs_in_snow.jpg")
print(f"path: {absolute_image_path}")
image = Image.open(absolute_image_path)
#Encode an image:
img_emb = model.encode(image)

#Encode text descriptions
# 选择一些文本描述
# text_descriptions = ["关注按钮", "跳转按钮", "66直播节"]
text_descriptions = ['Two dogs in the snow', 'A cat on a table', 'A picture of London at night']
text_emb = model.encode(text_descriptions)

#Compute cosine similarities 
cos_scores = util.cos_sim(img_emb, text_emb)
print(cos_scores)